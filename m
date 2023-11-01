Return-Path: <linux-fsdevel+bounces-1773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0AC7DE83D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 23:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7782EB2115B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 22:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEAC14F6E;
	Wed,  1 Nov 2023 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="A7TuGYbW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAB101EF
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 22:45:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9648F120;
	Wed,  1 Nov 2023 15:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3diwpSq3WWjuGaIf96sP2yWlOY+cLuH2Fz9QbBofL73qGIHEeYy5a2898Ao4NpqlErb4IdRJS0ISz6eN8SdF/otQ9CjFbk+VdxeKMDzJZk4ggOtMgRY9ViSPOgefbxRuP9kiJFI+c3D4fMS1wL6s8c/IY+SoclyQ+w/sWTZeoJTtSNQPOdCF8T3Z05RxpTWrwNnt8aQxIpJPFVBLthtA4vD9c21n91c+m2Vmkr4SItMWaMPiYAsJJTaEjNH9qTUl03i/RmSXAjWbV7wOOw5BLGlGSTzQE3tOkUeEi4dApYkEsMw7GaoUR1qXYm5VBhkvD955t6EKk+JaWJivf36kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86AuZVkHAJC/xJsPHsvl1SYoOAf/aZr7hKhJ9FBjqyc=;
 b=OLN84Yx3GAlLir53P9mw79bTCsVvPcq1kX+DTAGWQVdav2+FhKwZxhYCOQOqOwZYYrWFvbSiRxicgIkAahzrFvVYaWTZBDAZFtZ8v1e7sRj6VaTjo0NsnmgyjmyZioGOpk1xyn++UzZk6tVE4llsvG6JN8PiUelBxTH3kvOr0AVeShgUfHNZuumMpOP6bJqsFFjZTx/SSdIaTw50Sm8bu1n9eSMnq1te94A9orgRSIeh1QUwwDeVxq8Msp8t/v8L8xykj0BWX3oLFwU6Awwbg7qxowcXUD+KeM3tdX4OlLfzR3VHTAwPqUwyKzkfmvggyWKBOBJ6IGzVNaKIhDcbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86AuZVkHAJC/xJsPHsvl1SYoOAf/aZr7hKhJ9FBjqyc=;
 b=A7TuGYbWm1uF3BnuLj564R3XBbcYf+kRApBYJmLLW6NnaGzBdOMqRBuUPozO10YOgzPqfEuBzGKjQR7EZ+hvqyeM6eYe/ZLvKR3Od+G8gXPd8G+EdJi1hAa8dOywYWaDohZcEOFxKxfgjNnm24dxOTYDmeG51F0uakVTaOzdl0k=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 PH7PR13MB6481.namprd13.prod.outlook.com (2603:10b6:510:2ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.28; Wed, 1 Nov 2023 22:45:30 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%4]) with mapi id 15.20.6907.030; Wed, 1 Nov 2023
 22:45:29 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "hughd@google.com" <hughd@google.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "jstultz@google.com" <jstultz@google.com>,
	"brauner@kernel.org" <brauner@kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "djwong@kernel.org" <djwong@kernel.org>,
	"clm@fb.com" <clm@fb.com>, "chandan.babu@oracle.com"
	<chandan.babu@oracle.com>, "david@fromorbit.com" <david@fromorbit.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dsterba@suse.com"
	<dsterba@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "tytso@mit.edu" <tytso@mit.edu>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz"
	<jack@suse.cz>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>, "jack@suse.de" <jack@suse.de>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Thread-Topic: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Thread-Index:
 AQHaAepiwRK5xtu1cEOlqP7L4UYm0LBP6+MAgAAY74CAAAwxgIAABgCAgADCl4CAACFrAIAAsQcAgADtloCAA82AgIABFCGAgACRmICAAA52AIAAOIwAgAA6FACAAME+AIAA4QCAgABIsYCAAOlogIACHKEAgAWAfwCAAAm3AIAAKhyAgABZxYCAAEojAIAAr2uAgADOqACAAKXBgIAAF7UAgAANpQCAAAYPgA==
Date: Wed, 1 Nov 2023 22:45:29 +0000
Message-ID: <5ef49a42e95a5cb1a0ce77766c13e9f227cb446e.camel@hammerspace.com>
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area>
	 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
	 <ZTnNCytHLGoJY9ds@dread.disaster.area>
	 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
	 <ZUAwFkAizH1PrIZp@dread.disaster.area>
	 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
	 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
	 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
	 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
	 <ZUF4NTxQXpkJADxf@dread.disaster.area>
	 <20231101101648.zjloqo5su6bbxzff@quack3>
	 <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
	 <3ae88800184f03b152aba6e4a95ebf26e854dd63.camel@hammerspace.com>
	 <CAHk-=wi+cVOE3VmJzN3C6TFepszCkrXeAFJY6b7bK=vV493rzQ@mail.gmail.com>
In-Reply-To:
 <CAHk-=wi+cVOE3VmJzN3C6TFepszCkrXeAFJY6b7bK=vV493rzQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|PH7PR13MB6481:EE_
x-ms-office365-filtering-correlation-id: ba66cf14-b78a-42c0-9a21-08dbdb2c3f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1D8RPLwL1Rq577oskRqVdIamWLXmi7X1roKz98NzTjfuAsqWbc47YAAX0hc9H4pgeXi7YIsUU2iw4ACVfQUuTrm1V9PFMlr1vsrBCQdIQSD4JFhQvsCsWHjAvkETc4AlHVB9MXLNZ7tV+gGwuN10hS8aAsRPHhFiMQblVnIiqQCDbNackrvaDWdHMSLpaHCt1EhJEFRf8RmBib5r8YqzHLpgW+K+/A7hSFm6BJcKhPpCkkkLRggshmTnt+1/pnBsJ0BLXj2ebUazF5KGmmqj5e0JWUTz6Dssfhhr7NnOdcaMEunw7QJVLfrVbmAsMrOpY3XbiOTDiAkwBLBWk7Z+7oh/RzS6qdRhGrOQmbZpTLAcaZnDpX9ys6Lzvn7bqFUHe/JNXOjKzTpXSrbDllCkEDrKJvzqDNmV4roBkt7WmvhgZFFfFsU1GNpbFwvQ0CAl70iD711npo3rkFZJFF4L/f0wuAXdzD6Rv0L+C1d4DF6RLS6jefV0ld3Jxu7ZKtisBZfErAop06gzqWkj9+yw4Dp1LErP86zFc1RPJVh5B51NZhQ2yCTIOXpVhTFOZbr+vmZNRQC2N0QeYLmXFHEH3c3zkNjcRgH/MRANz77VL2nfg0Fzc2EvkEh1y60AQSaCkzrA4kK+7ydnRNt66KvLyUjDkQOIWGON2PN80ZSg/2o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39840400004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(86362001)(36756003)(122000001)(38070700009)(5660300002)(6486002)(41300700001)(6512007)(83380400001)(4326008)(478600001)(8676002)(66556008)(8936002)(71200400001)(76116006)(2616005)(6506007)(2906002)(7416002)(66946007)(91956017)(316002)(6916009)(66446008)(64756008)(66476007)(54906003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2xWelFRQ2pqQmpEYUZ1UHdtdngvODNmeUZQaEFOV1ViY2xJSXROemFOWGFq?=
 =?utf-8?B?cGZuL2Q4U0kwamp4SnprQmFMa29nTjJQR0psZi9US01iZUg4dCtObk5OWU10?=
 =?utf-8?B?ZjltWURkazA2VzdSQ3Q1MEhZQTJRUitDODBVQi9mSm1wZjRlZVZINWJsMWxt?=
 =?utf-8?B?WEk4ZEpkbE9sang2cVlIc0ZmKytjSHkzZk1CSkNmV1BMSlJ6cUhXTnBzTmxG?=
 =?utf-8?B?cmtJcE15VmptUEFyVkc2ckpQSkloRVJoaSs5Q201aWhtbVZRb1J4ekZzVjZz?=
 =?utf-8?B?WG5Da2x1Wi9PT0FRbGZSa2tCa1FyVnFCTS9oSCt4aE1OeS84WktyUnhBcjRS?=
 =?utf-8?B?ck1HTkJRVUVETGdxVjZkNlJ4ZE81MVFaLzRpaEZtL2JiUW8vS2txSmNSSm1r?=
 =?utf-8?B?Q3dBSVFLOFA5U1dVVDhLRWRHblZ5VTJFNEphU21PbHVUVVRieXl3aVRRc3pq?=
 =?utf-8?B?YjZadG16MEUvSTNQYTNDYzlDbVc5N3BMTFN4Nzg1cVp2ODFKN3ZyazlIY1Mx?=
 =?utf-8?B?dndGaDFzMzNPOFFMdExqZW9pMXdlUEFDTW1Mci9CeTUzQ1hZWnhpQXd3RlYw?=
 =?utf-8?B?STd0amtCVDJuNHJ5djVLcUk1REZoSEF6NGNKNkdoWCswYm5YK1NiWWlNeUtS?=
 =?utf-8?B?ekxGc0xJT013ZExxWDZiTVluT1pHTy9jaldOc0RrMHBDM1dmSWQySUVSYnND?=
 =?utf-8?B?TXdaSEtyb2daS3B2UmVYSUVpcDhHR2lVZEs0YVQ4RDlPRnFxTDBNQU5VUW5R?=
 =?utf-8?B?UVRzVS82MEJXclpPZ2Y3eGF1S1ZHem8xcjNRUTU3ekFxaUZja3RScDNhRHd3?=
 =?utf-8?B?MCszdUtWdFdRUWxLT1BwWjArZTUwZ0hWdGJyZ1pXUERGMkdLRXBibHMwNmtj?=
 =?utf-8?B?NXEzN0w1UE1QMlJsT2JrdTFZTVhHYnhFejRiZm5zdmxhWHVyUFlxZFVVRk9o?=
 =?utf-8?B?K0pScCtyeTFpM2lYZWdVRkRSaDR3d2NXZ0VFS25GWWpISWNYMXBJbFVwanlQ?=
 =?utf-8?B?NE80TU5EeVByODNJVWFzMjBmMjRLZUdJWHVhbjBWUjZZUU05M2d1SDkwbGZr?=
 =?utf-8?B?KzMyU3ZEaG9kVnpwQjEyZG1KUGR2SHZ6bGRlVnl6aUk4cmYvM0IrcDk5cXd6?=
 =?utf-8?B?MmNlNkpiZjVFcXdrdnJXWVRlQXFId3RKeW9NSkcwa2xjYnNsZm5mSkorb1Ny?=
 =?utf-8?B?dDJFdVJFT0RDYi9STXJsTHR5bCtSRDBOYW5xcjdlT3RVZzhjTUViVkdxOS82?=
 =?utf-8?B?TUdEWGFnYnM5YXMzZTlNYUpidlFhVXBzVjIvTG1uNi9qMXFCNWJ1RE9hM1dy?=
 =?utf-8?B?Umt0OHZTbEY2Rk45aFpOVDFVYnBhaXE2TFBtU3l5eWpseWxpc2tZZWJ1WHps?=
 =?utf-8?B?elRxbm5lNUhibTd0aTVYdUF1RVhkbUw0THd3YU53OFRYVUp6K2daNEV5b0Za?=
 =?utf-8?B?MWJQYlh0OURxOThNS1h5RzZPWWsya042L3VsSDYzL1c3Nlo4ajFaQVk3OUcw?=
 =?utf-8?B?ZjRrRGp3NE9xS04vRkY3Z2E3ZC9EcUI0K2VqSnRhd2dLbU92Y0t2cXAxWFNU?=
 =?utf-8?B?Z2Z3N0RIcmt2Q0UvV0psTUFKN0JtQ045L2owcGxpMHJDV1JOamtUZ2hNRWhG?=
 =?utf-8?B?d0VmS0oyR1hTUWh3S1JDcVluRzFBdkdSRC8zODlhTWpoaGNvKyt5d25pQ3Nm?=
 =?utf-8?B?U3pYUldHNTQ2b1dKcm5iUWFWMXJMRG44c1JVTEdNTy9mY2tWTStsc1Byb1hj?=
 =?utf-8?B?M3I0SWZxM1d1bGR1bGhqTGZoWXduVzFweWtSWitqUXB0Mmd6b28xU3RsZTJI?=
 =?utf-8?B?OWxhNjVHZXJwUDM5SFkyd0JrR2xCVmkzVWZSVFdEbXE1RVphRVZST2J3RVpo?=
 =?utf-8?B?N01qc3ltdWoxVm5uRkdwbGx1VVZ3MmVMMHc4MFJXck8yb01KSi82YzNSeGJw?=
 =?utf-8?B?RE5kRlgvSmZRbmdNKy9aTlpnY2RGNnZRUStidW80eTFqNTYxcTJjV0VjUUtH?=
 =?utf-8?B?ckk2a0s5cmpaKzhPd3ptZ1F5TVhLWC9nR0szNjhwSlU3VnE5Z3cwbEx3VGY3?=
 =?utf-8?B?V3VyUUdKQnN3dm9PTnN5MThVSmpBOEZkaWx1N3Y0Mjh4d0Vad2FwcHB1aTJu?=
 =?utf-8?B?Nkgwd1d0RWpHS1F4ZUc4SXBWNHFiNlZCQlU2dnV2dmRGVUNNbmtzZXYxOG42?=
 =?utf-8?B?T3oxME5wSTFWSlhSdUZtNmhQeWZ6TjJqSjVJYVEvT29tbW5oQTFKcllkb0tr?=
 =?utf-8?B?RTh1ZlFGWExKMVpZeUpWWXgrRDhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <465884FF5296734AADBA0B33FCC0CB51@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba66cf14-b78a-42c0-9a21-08dbdb2c3f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 22:45:29.3301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2TVntkhavtecmH5SLiKDuJt1+yK7NGDcpHVCdgzWLhBE1jid8n9SLX71I/TbPrybtY9xBVvE7kVS6wucKp/aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6481

T24gV2VkLCAyMDIzLTExLTAxIGF0IDEyOjIzIC0xMDAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gV2VkLCBOb3YgMSwgMjAyMywgMTE6MzUgVHJvbmQgTXlrbGVidXN0IDx0cm9uZG15QGhh
bW1lcnNwYWNlLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gTXkgY2xpZW50IHdyaXRlcyB0byB0
aGUgZmlsZSBhbmQgaW1tZWRpYXRlbHkgcmVhZHMgdGhlIGN0aW1lLiBBIDNyZA0KPiA+IHBhcnR5
IGNsaWVudCB0aGVuIHdyaXRlcyBpbW1lZGlhdGVseSBhZnRlciBteSBjdGltZSByZWFkLg0KPiA+
IEEgcmVib290IG9jY3VycyAobWF5YmUgbWludXRlcyBsYXRlciksIHRoZW4gSSByZS1yZWFkIHRo
ZSBjdGltZSwNCj4gPiBhbmQNCj4gPiBnZXQgdGhlIHNhbWUgdmFsdWUgYXMgYmVmb3JlIHRoZSAz
cmQgcGFydHkgd3JpdGUuDQo+ID4gDQo+ID4gWWVzLCBtb3N0IG9mIHRoZSB0aW1lIHRoYXQgaXMg
YmV0dGVyIHRoYW4gdGhlIG5ha2VkIGN0aW1lLCBidXQgbm90DQo+ID4gYWNyb3NzIGEgcmVib290
Lg0KPiANCj4gQWhoLCBJIGtuZXcgSSB3YXMgbWlzc2luZyBzb21ldGhpbmcuDQo+IA0KPiBCdXQg
SSB0aGluayBpdCdzIGZpeGFibGUsIHdpdGggYW4gYWRkaXRpb25hbCBydWxlOg0KPiANCj4gwqAt
IHdoZW4gZ2VuZXJhdGluZyBTVEFUWF9DSEFOR0VfQ09PS0lFLCBpZiB0aGUgY3RpbWUgbWF0Y2hl
cyB0aGUNCj4gY3VycmVudCB0aW1lIGFuZCB0aGUgY3RpbWUgY291bnRlciBpcyB6ZXJvLCBzZXQg
dGhlIGN0aW1lIGNvdW50ZXIgdG8NCj4gMS4NCj4gDQo+IFRoYXQgbWVhbnMgdGhhdCB5b3Ugd2ls
bCBoYXZlICpzcHVyaW91cyogY2FjaGUgaW52YWxpZGF0aW9ucyBvZiBzdWNoDQo+IGNhY2hlZCBk
YXRhIGFmdGVyIGEgcmVib290LCBidXQgb25seSBmb3IgcmVhZHMgdGhhdCBoYXBwZW5lZCByaWdo
dA0KPiBhZnRlciB0aGUgZmlsZSB3YXMgd3JpdHRlbi4NCg0KUHJlc3VtYWJseSBpdCB3aWxsIGFs
c28gaGFwcGVuIGlmIHRoZSBmaWxlIGdldHMga2lja2VkIG91dCBvZiBjYWNoZSBvbg0KdGhlIHNl
cnZlciwgc2luY2UgdGhhdCB3aWxsIGNhdXNlIHRoZSBJX1ZFUlNJT05fUVVFUklFRCBmbGFnIGFu
ZCBhbnkNCm90aGVyIGluLW1lbW9yeSBtZXRhZGF0YSB0byBiZSBsb3N0Lg0KDQo+IA0KPiBOb3cs
IGl0J3Mgb2J2aW91c2x5IG5vdCB1bmhlYXJkIG9mIHRvIGZpbmlzaCB3cml0aW5nIGEgZmlsZSwg
YW5kIHRoZW4NCj4gaW1tZWRpYXRlbHkgcmVhZGluZyB0aGUgcmVzdWx0cyBhZ2Fpbi4NCj4gDQo+
IEJ1dCBhdCBsZWFzdCB0aG9zZSBjYWNoZXMgc2hvdWxkIGJlIHNvbWV3aGF0IGxpbWl0ZWQgKGFu
ZCB0aGUgcHJvYmxlbQ0KPiB0aGVuIG9ubHkgaGFwcGVucyB3aGVuIHRoZSBuZnMgc2VydmVyIGlz
IHJlYm9vdGVkKS4NCj4gDQo+IEkgKmFzc3VtZSogdGhhdCB0aGUgd2hvbGUgdGh1bmRlcmluZyBo
ZXJkIGlzc3VlIHdpdGggbG90cyBvZiBjbGllbnRzDQo+IHRlbmRzIHRvIGJlIGZvciBzdGFibGUg
ZmlsZXMsIG5vdCBmaWxlcyB0aGF0IHdlcmUganVzdCB3cml0dGVuIGFuZA0KPiB0aGVuIGltbWVk
aWF0ZWx5IGNhY2hlZD8NCj4gDQo+IEkgZHVubm8uIEknbSBzdXJlIHRoZXJlJ3Mgc3RpbGwgc29t
ZSB0aGlua28gaGVyZS4NCg0KQ2xvc2UtdG8tb3BlbiBjYWNoZSBjb25zaXN0ZW5jeSBtZWFucyB0
aGF0IHRoZSBjbGllbnQgaXMgdXN1YWxseQ0KZXhwZWN0ZWQgdG8gY2hlY2sgdGhlIGNoYW5nZSBh
dHRyaWJ1dGUgKG9yIGN0aW1lKSBvbiBmaWxlIGNsb3NlIGFuZA0KZmlsZSBvcGVuLiBTbyBpdCBp
cyBub3QgdW5jb21tb24gZm9yIGl0IHRvIGhhdmUgdG8gcmV2YWxpZGF0ZSB0aGUgY2FjaGUNCm5v
dCBsb25nIGFmdGVyIGZpbmlzaGluZyB3cml0aW5nIHRoZSBmaWxlLiBPZiBjb3Vyc2UsIGl0IGlz
IHJhcmUgdG8NCmhhdmUgYW5vdGhlciBjbGllbnQgaW50ZXJqZWN0IHdpdGggYW5vdGhlciB3cml0
ZSB0byB0aGUgc2FtZSBmaWxlIGp1c3QNCmEgZmV3IG1pY3Jvc2Vjb25kcyBhZnRlciBpdCB3YXMg
Y2xvc2VkLCBob3dldmVyIGl0IGlzIGV4dHJlbWVseSBjb21tb24NCmZvciB0aGF0IHNvcnQgb2Yg
YmVoYXZpb3VyIHRvIG9jY3VyIHdpdGggZGlyZWN0b3JpZXMuDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

