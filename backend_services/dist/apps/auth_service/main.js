/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "./apps/auth_service/src/auth_service.controller.ts"
/*!**********************************************************!*\
  !*** ./apps/auth_service/src/auth_service.controller.ts ***!
  \**********************************************************/
(__unused_webpack_module, exports, __webpack_require__) {


var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var _a;
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.AuthServiceController = void 0;
const common_1 = __webpack_require__(/*! @nestjs/common */ "@nestjs/common");
const auth_service_service_1 = __webpack_require__(/*! ./auth_service.service */ "./apps/auth_service/src/auth_service.service.ts");
const standard_response_interceptor_1 = __webpack_require__(/*! ../../../libs/shared/src/interceptors/standard-response.interceptor */ "./libs/shared/src/interceptors/standard-response.interceptor.ts");
let AuthServiceController = class AuthServiceController {
    authService;
    constructor(authService) {
        this.authService = authService;
    }
    login(body) {
        return this.authService.login(body);
    }
    register(body) {
        return this.authService.register(body);
    }
    logout() {
        return { message: 'Logged out successfully' };
    }
    getMe() {
        return { id: '123', email: 'test@example.com' };
    }
};
exports.AuthServiceController = AuthServiceController;
__decorate([
    (0, common_1.Post)('login'),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], AuthServiceController.prototype, "login", null);
__decorate([
    (0, common_1.Post)('register'),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], AuthServiceController.prototype, "register", null);
__decorate([
    (0, common_1.Post)('logout'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], AuthServiceController.prototype, "logout", null);
__decorate([
    (0, common_1.Get)('me'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], AuthServiceController.prototype, "getMe", null);
exports.AuthServiceController = AuthServiceController = __decorate([
    (0, common_1.Controller)('auth'),
    (0, common_1.UseInterceptors)(standard_response_interceptor_1.StandardResponseInterceptor),
    __metadata("design:paramtypes", [typeof (_a = typeof auth_service_service_1.AuthServiceService !== "undefined" && auth_service_service_1.AuthServiceService) === "function" ? _a : Object])
], AuthServiceController);


/***/ },

/***/ "./apps/auth_service/src/auth_service.module.ts"
/*!******************************************************!*\
  !*** ./apps/auth_service/src/auth_service.module.ts ***!
  \******************************************************/
(__unused_webpack_module, exports, __webpack_require__) {


var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.AuthServiceModule = void 0;
const common_1 = __webpack_require__(/*! @nestjs/common */ "@nestjs/common");
const auth_service_controller_1 = __webpack_require__(/*! ./auth_service.controller */ "./apps/auth_service/src/auth_service.controller.ts");
const auth_service_service_1 = __webpack_require__(/*! ./auth_service.service */ "./apps/auth_service/src/auth_service.service.ts");
const prisma_service_1 = __webpack_require__(/*! ./prisma.service */ "./apps/auth_service/src/prisma.service.ts");
const jwt_1 = __webpack_require__(/*! @nestjs/jwt */ "@nestjs/jwt");
const calls_module_1 = __webpack_require__(/*! ./calls/calls.module */ "./apps/auth_service/src/calls/calls.module.ts");
let AuthServiceModule = class AuthServiceModule {
};
exports.AuthServiceModule = AuthServiceModule;
exports.AuthServiceModule = AuthServiceModule = __decorate([
    (0, common_1.Module)({
        imports: [
            jwt_1.JwtModule.register({
                secret: 'super-secret-jwt-key',
                signOptions: { expiresIn: '1h' },
            }),
            calls_module_1.CallsModule,
        ],
        controllers: [auth_service_controller_1.AuthServiceController],
        providers: [auth_service_service_1.AuthServiceService, prisma_service_1.PrismaService],
    })
], AuthServiceModule);


/***/ },

/***/ "./apps/auth_service/src/auth_service.service.ts"
/*!*******************************************************!*\
  !*** ./apps/auth_service/src/auth_service.service.ts ***!
  \*******************************************************/
(__unused_webpack_module, exports, __webpack_require__) {


var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var _a, _b;
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.AuthServiceService = void 0;
const common_1 = __webpack_require__(/*! @nestjs/common */ "@nestjs/common");
const prisma_service_1 = __webpack_require__(/*! ./prisma.service */ "./apps/auth_service/src/prisma.service.ts");
const jwt_1 = __webpack_require__(/*! @nestjs/jwt */ "@nestjs/jwt");
const bcrypt = __importStar(__webpack_require__(/*! bcrypt */ "bcrypt"));
let AuthServiceService = class AuthServiceService {
    prisma;
    jwtService;
    constructor(prisma, jwtService) {
        this.prisma = prisma;
        this.jwtService = jwtService;
    }
    async register(body) {
        const { email, password, role } = body;
        const existingUser = await this.prisma.user.findUnique({ where: { email } });
        if (existingUser)
            throw new common_1.BadRequestException('User already exists');
        const passwordHash = await bcrypt.hash(password, 10);
        const user = await this.prisma.user.create({
            data: { email, passwordHash, role: role || 'player' },
        });
        const token = this.jwtService.sign({ userId: user.id, role: user.role });
        return { user: { id: user.id, email: user.email, role: user.role }, accessToken: token };
    }
    async login(body) {
        const { email, password } = body;
        const user = await this.prisma.user.findUnique({ where: { email } });
        if (!user)
            throw new common_1.UnauthorizedException('Invalid credentials');
        const isValid = await bcrypt.compare(password, user.passwordHash);
        if (!isValid)
            throw new common_1.UnauthorizedException('Invalid credentials');
        const token = this.jwtService.sign({ userId: user.id, role: user.role });
        return { user: { id: user.id, email: user.email, role: user.role }, accessToken: token };
    }
};
exports.AuthServiceService = AuthServiceService;
exports.AuthServiceService = AuthServiceService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [typeof (_a = typeof prisma_service_1.PrismaService !== "undefined" && prisma_service_1.PrismaService) === "function" ? _a : Object, typeof (_b = typeof jwt_1.JwtService !== "undefined" && jwt_1.JwtService) === "function" ? _b : Object])
], AuthServiceService);


/***/ },

/***/ "./apps/auth_service/src/calls/calls.gateway.ts"
/*!******************************************************!*\
  !*** ./apps/auth_service/src/calls/calls.gateway.ts ***!
  \******************************************************/
(__unused_webpack_module, exports, __webpack_require__) {


var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var _a, _b, _c, _d, _e;
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.CallsGateway = void 0;
const websockets_1 = __webpack_require__(/*! @nestjs/websockets */ "@nestjs/websockets");
const socket_io_1 = __webpack_require__(/*! socket.io */ "socket.io");
let CallsGateway = class CallsGateway {
    server;
    activeUsers = new Map();
    handleConnection(client) {
        const userId = client.handshake.query.userId;
        if (userId) {
            this.activeUsers.set(userId, client.id);
            console.log(`[CallsGateway] User connected: ${userId} (Socket: ${client.id})`);
        }
    }
    handleDisconnect(client) {
        const userId = client.handshake.query.userId;
        if (userId) {
            this.activeUsers.delete(userId);
            console.log(`[CallsGateway] User disconnected: ${userId}`);
        }
    }
    handleOffer(payload, client) {
        const targetSocket = this.activeUsers.get(payload.targetUserId);
        if (targetSocket) {
            this.server.to(targetSocket).emit('call-offer', {
                offer: payload.offer,
                callerId: payload.callerId,
            });
        }
    }
    handleAnswer(payload, client) {
        const targetSocket = this.activeUsers.get(payload.targetUserId);
        if (targetSocket) {
            this.server.to(targetSocket).emit('call-answer', {
                answer: payload.answer,
            });
        }
    }
    handleIceCandidate(payload, client) {
        const targetSocket = this.activeUsers.get(payload.targetUserId);
        if (targetSocket) {
            this.server.to(targetSocket).emit('ice-candidate', {
                candidate: payload.candidate,
            });
        }
    }
    handleEndCall(payload, client) {
        const targetSocket = this.activeUsers.get(payload.targetUserId);
        if (targetSocket) {
            this.server.to(targetSocket).emit('call-ended');
        }
    }
};
exports.CallsGateway = CallsGateway;
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", typeof (_a = typeof socket_io_1.Server !== "undefined" && socket_io_1.Server) === "function" ? _a : Object)
], CallsGateway.prototype, "server", void 0);
__decorate([
    (0, websockets_1.SubscribeMessage)('call-offer'),
    __param(0, (0, websockets_1.MessageBody)()),
    __param(1, (0, websockets_1.ConnectedSocket)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, typeof (_b = typeof socket_io_1.Socket !== "undefined" && socket_io_1.Socket) === "function" ? _b : Object]),
    __metadata("design:returntype", void 0)
], CallsGateway.prototype, "handleOffer", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('call-answer'),
    __param(0, (0, websockets_1.MessageBody)()),
    __param(1, (0, websockets_1.ConnectedSocket)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, typeof (_c = typeof socket_io_1.Socket !== "undefined" && socket_io_1.Socket) === "function" ? _c : Object]),
    __metadata("design:returntype", void 0)
], CallsGateway.prototype, "handleAnswer", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('ice-candidate'),
    __param(0, (0, websockets_1.MessageBody)()),
    __param(1, (0, websockets_1.ConnectedSocket)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, typeof (_d = typeof socket_io_1.Socket !== "undefined" && socket_io_1.Socket) === "function" ? _d : Object]),
    __metadata("design:returntype", void 0)
], CallsGateway.prototype, "handleIceCandidate", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('end-call'),
    __param(0, (0, websockets_1.MessageBody)()),
    __param(1, (0, websockets_1.ConnectedSocket)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, typeof (_e = typeof socket_io_1.Socket !== "undefined" && socket_io_1.Socket) === "function" ? _e : Object]),
    __metadata("design:returntype", void 0)
], CallsGateway.prototype, "handleEndCall", null);
exports.CallsGateway = CallsGateway = __decorate([
    (0, websockets_1.WebSocketGateway)({ cors: { origin: '*' } })
], CallsGateway);


/***/ },

/***/ "./apps/auth_service/src/calls/calls.module.ts"
/*!*****************************************************!*\
  !*** ./apps/auth_service/src/calls/calls.module.ts ***!
  \*****************************************************/
(__unused_webpack_module, exports, __webpack_require__) {


var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.CallsModule = void 0;
const common_1 = __webpack_require__(/*! @nestjs/common */ "@nestjs/common");
const calls_gateway_1 = __webpack_require__(/*! ./calls.gateway */ "./apps/auth_service/src/calls/calls.gateway.ts");
let CallsModule = class CallsModule {
};
exports.CallsModule = CallsModule;
exports.CallsModule = CallsModule = __decorate([
    (0, common_1.Module)({
        providers: [calls_gateway_1.CallsGateway],
    })
], CallsModule);


/***/ },

/***/ "./apps/auth_service/src/prisma.service.ts"
/*!*************************************************!*\
  !*** ./apps/auth_service/src/prisma.service.ts ***!
  \*************************************************/
(__unused_webpack_module, exports, __webpack_require__) {


var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.PrismaService = void 0;
const common_1 = __webpack_require__(/*! @nestjs/common */ "@nestjs/common");
const client_1 = __webpack_require__(/*! @prisma/client */ "@prisma/client");
let PrismaService = class PrismaService extends client_1.PrismaClient {
    constructor() {
        super();
    }
    async onModuleInit() {
        await this.$connect();
    }
};
exports.PrismaService = PrismaService;
exports.PrismaService = PrismaService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [])
], PrismaService);


/***/ },

/***/ "./libs/shared/src/interceptors/standard-response.interceptor.ts"
/*!***********************************************************************!*\
  !*** ./libs/shared/src/interceptors/standard-response.interceptor.ts ***!
  \***********************************************************************/
(__unused_webpack_module, exports, __webpack_require__) {


var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.StandardResponseInterceptor = void 0;
const common_1 = __webpack_require__(/*! @nestjs/common */ "@nestjs/common");
const operators_1 = __webpack_require__(/*! rxjs/operators */ "rxjs/operators");
let StandardResponseInterceptor = class StandardResponseInterceptor {
    intercept(context, next) {
        return next.handle().pipe((0, operators_1.map)(data => ({
            success: true,
            data: data || {},
            error: null,
        })));
    }
};
exports.StandardResponseInterceptor = StandardResponseInterceptor;
exports.StandardResponseInterceptor = StandardResponseInterceptor = __decorate([
    (0, common_1.Injectable)()
], StandardResponseInterceptor);


/***/ },

/***/ "@nestjs/common"
/*!*********************************!*\
  !*** external "@nestjs/common" ***!
  \*********************************/
(module) {

module.exports = require("@nestjs/common");

/***/ },

/***/ "@nestjs/core"
/*!*******************************!*\
  !*** external "@nestjs/core" ***!
  \*******************************/
(module) {

module.exports = require("@nestjs/core");

/***/ },

/***/ "@nestjs/jwt"
/*!******************************!*\
  !*** external "@nestjs/jwt" ***!
  \******************************/
(module) {

module.exports = require("@nestjs/jwt");

/***/ },

/***/ "@nestjs/websockets"
/*!*************************************!*\
  !*** external "@nestjs/websockets" ***!
  \*************************************/
(module) {

module.exports = require("@nestjs/websockets");

/***/ },

/***/ "@prisma/client"
/*!*********************************!*\
  !*** external "@prisma/client" ***!
  \*********************************/
(module) {

module.exports = require("@prisma/client");

/***/ },

/***/ "bcrypt"
/*!*************************!*\
  !*** external "bcrypt" ***!
  \*************************/
(module) {

module.exports = require("bcrypt");

/***/ },

/***/ "rxjs/operators"
/*!*********************************!*\
  !*** external "rxjs/operators" ***!
  \*********************************/
(module) {

module.exports = require("rxjs/operators");

/***/ },

/***/ "socket.io"
/*!****************************!*\
  !*** external "socket.io" ***!
  \****************************/
(module) {

module.exports = require("socket.io");

/***/ }

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		if (!(moduleId in __webpack_modules__)) {
/******/ 			delete __webpack_module_cache__[moduleId];
/******/ 			var e = new Error("Cannot find module '" + moduleId + "'");
/******/ 			e.code = 'MODULE_NOT_FOUND';
/******/ 			throw e;
/******/ 		}
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
// This entry needs to be wrapped in an IIFE because it needs to be isolated against other modules in the chunk.
(() => {
var exports = __webpack_exports__;
/*!***************************************!*\
  !*** ./apps/auth_service/src/main.ts ***!
  \***************************************/

Object.defineProperty(exports, "__esModule", ({ value: true }));
const core_1 = __webpack_require__(/*! @nestjs/core */ "@nestjs/core");
const auth_service_module_1 = __webpack_require__(/*! ./auth_service.module */ "./apps/auth_service/src/auth_service.module.ts");
async function bootstrap() {
    const app = await core_1.NestFactory.create(auth_service_module_1.AuthServiceModule);
    await app.listen(process.env.port ?? 3000);
}
bootstrap();

})();

/******/ })()
;