Return-Path: <linux-fsdevel+bounces-531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EBE7CC5E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38264281A72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311A43AB9;
	Tue, 17 Oct 2023 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Vq8RGzQE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286C043AB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 14:27:05 +0000 (UTC)
Received: from outbound-ip160a.ess.barracuda.com (outbound-ip160a.ess.barracuda.com [209.222.82.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22C2B0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 07:26:33 -0700 (PDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101]) by mx-outbound13-110.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 17 Oct 2023 14:25:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5SFn9mWBygUoc4HA6X945za/38jh2XIGV0VHGVQCVI+p6WepkpOJZ5hBFIW6hvy4DzpWezpo76IAdRISIMJnMOKhX4/jQKHjrAn/bLMJA3UlyidOaisgsxPdXWYGI/XnYXZQ8A0wauHR6mwZik//8lc0MXmju2oaoosyNKHWf844o0hlbdaN4Qb4WzjDQUR3iJPY69Dqyy2VK+1gry9MkwwKz398lW7wyuDelpurCeX9Kg+rFOsEOBnEx8V1f/wCOmnZWTFQkJUHw7lHzEZ/y50mJ5h0pHA/zbhgUDLEqPVXS/iwmwmCT9YV9sJQtWtW59uhKWjpMjIeT+v9dwEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yd7Lw2yYN0wqDqcqVoeyIPcrMlccuHXezgBhLeON3Wg=;
 b=BEU73XsFT9Kfs6jIGC0AznyBlHefO+YR01gySQIQY7dmolws9QmqbKLu8ipCl2e8BpIoO7hVLXsMGie4fP1+njG8n1xj0PL4HKiax5dQMygz4tFl51tfBXdJILIQAoBf/joRPhu0SNmwlNQmCiX2Pqw/CtrlujCJyx6bZvoDDhhVeueg2aBmsUCZE7spN+Ku44ou4YeNgA87SAs0Cc/QtOkQgwy2t9nXNGLY89f/rmnXRreo6zXiuwz6Pde/YOYjiHPkpxRUn7ANAv2+Kdi0KM2P5dbYaz7TxWdD22W5eHAXiIV+45WvNVH+1ORUKwKZZwJBtRS3mpU0RfHBmpYG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd7Lw2yYN0wqDqcqVoeyIPcrMlccuHXezgBhLeON3Wg=;
 b=Vq8RGzQEJwstympjSmCdVDUPyMfD7BmfIRKnygfUfh1NVrOWVsQLN/sf/Bt0Cu63tgFBcvsc7W+XyMYuYVGbpRgh/8jNpBdNu/N3WssffSdPK/WlBcnriluN50ypXot+65s7TAnwdGDwSHxiIAelnsVCY9UXKM/TuZpKwJMNSBA=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by PH7PR19MB5703.namprd19.prod.outlook.com (2603:10b6:510:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 14:25:51 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:25:51 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "lkp@intel.com" <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "bernd.schubert@fastmail.fm"
	<bernd.schubert@fastmail.fm>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
	Dharmendra Singh <dsingh@ddn.com>, Christian Brauner <brauner@kernel.org>, Al
 Viro <viro@zeniv.linux.org.uk>, Yuan Yao <yuanyaogoog@chromium.org>
Subject: Re: [PATCH v9 4/7] vfs: Optimize atomic_open() on positive dentry
Thread-Topic: [PATCH v9 4/7] vfs: Optimize atomic_open() on positive dentry
Thread-Index: AQHZ6+jFLCLoWM452USVVZ2LjlAhuLBETiAAgAnltQA=
Date: Tue, 17 Oct 2023 14:25:51 +0000
Message-ID: <861d182d-b257-45e5-8459-0849dab3efd8@ddn.com>
References: <f1b371ce-9fa7-4d1c-bcad-968d1706ac99@kadam.mountain>
In-Reply-To: <f1b371ce-9fa7-4d1c-bcad-968d1706ac99@kadam.mountain>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|PH7PR19MB5703:EE_
x-ms-office365-filtering-correlation-id: 629410a6-af60-40cb-b671-08dbcf1cf719
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Dmaemzmzt3Nq0sKxeAJxiMEL/RnzR29LUuWN+ywkfuhTZqV6asRTpiG25D9hyYRGOEx7Jn7rKMP6VrZlkFE6Y8JW8/vvPUjjPGRoDHmjhCGQLkIF3ESd5n968EGhE/Kqet1XOU+akfhtpfUCwVljUUeb6b3wjZ5dBD2639UXYC/tSzlVBxlUQbUAkkeYOTDzNFOoomCtn1gGqwRmqpoV2JuJw4VvKSAPvPYJspKL1S7fXLwnJwet1SkRAsybLMzpqqrQ8w7knKbO/S+pNJeQ3bM1gWaUltBGceMU9JOVqF8C+YMNYFPwQO55kWKC2A3+6SufZv2hra6AhLSuq2yx4z0uZDy3+7cqiXAlMpyI6XSQpE0Um6aq5cXSYeYaJUDmq2ytWDWbCVGLtE5v0drxhe1RuNUXpUc0vFXrq7zf2iSEfbkj861RUz0BRcSqAi2fjIp6NGfCa6NNcXiL1hxbRFU1RGmSu5O5siKW4J/lrgXW3nz1p3S/qxxqRWTKGY514huTP2/0ghJpvylCs9Lbe0hCuioEHx+YJr3XKrSeNY6DaYHbXzaR6nbQwlgkF9MLMoACsxMk9O4OKZa5Z3njCMoGen7QqaoFFZ2+XnSrKGUGnvRYz8oCtS+KKnkBV9XtMPfgaIUR6ulqmCVJRYcFYl+TPwVyzZJJrLSdfWZsYFvPNOMbrARDj8+2bFOYk4zCm50Cjdyj3PLruC7tAwrdgg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(86362001)(38070700005)(31696002)(31686004)(36756003)(76116006)(6486002)(478600001)(966005)(316002)(5660300002)(54906003)(64756008)(66476007)(66946007)(66556008)(66446008)(38100700002)(122000001)(110136005)(6512007)(6506007)(53546011)(71200400001)(91956017)(2616005)(4326008)(8936002)(8676002)(83380400001)(41300700001)(7416002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW56bGZ0MVdwdndFVTl4aGpidVc1TmMzR0ZrWXZaTEU1QVJXMitiTmM3WmRa?=
 =?utf-8?B?Z0h5YXZwck11V1Y1MVFXeGVpY0pWdFlkREFvUjRmVzY2dEhENHZIeXRMVjBp?=
 =?utf-8?B?OEhjV04vaUpvZk1sR296a1NYajlLaHdIUzJUd3RQRnVDS1FNdGh5SVpNaENq?=
 =?utf-8?B?N1FXRm42SFVLc3BzSGhrcTMwSXZ5blRjVVVEKzZiSVVZS3M1OHRhTE9Rb0lN?=
 =?utf-8?B?dEhENnBLL1lMRXZhbGhRSnJTNFdIQUoweElpblBjeTV2c3lpd0U1dHBjYWk5?=
 =?utf-8?B?bEZJbzFkZ3JJWGVxcXFEYTRBNmVrcmF2ZE9lUzBYbE5oTGQyeDNNNThvNHlE?=
 =?utf-8?B?VXpPRmVhbzFiUXBMYWJlWGFZNnNTUU12QW1pOURPK2owTExlUXp1N2pJYStQ?=
 =?utf-8?B?THc2UlVHQ045VHdINVdOWUlrVHdONWRGYllQYlBrdzZIcy9QYzMzZ1hYT29P?=
 =?utf-8?B?bnhKamRvRmsrWC9kZHp5SVdVLzNhM1ZWYkpUK3Y4ZkljTVdyUWpLck1rWFpw?=
 =?utf-8?B?b2p2M1o5QXRYVEVZcUNYUXhVNjIvaEpJOENoUGxGT3FHcnc1ckdsQlV2RFEw?=
 =?utf-8?B?MG14Q3h1SDVLL09vVkl4ZVVmUWV5REx2VnpjM28wSjVCNmxyYXhuWm5JUU95?=
 =?utf-8?B?cnNORm9DVWdCMGdHbnh0Z1B2c2tCMFI4Y09lK3BXSWFyU25hUUljTm91dWZp?=
 =?utf-8?B?UmZQWTJtUVVjaWNaRmFhQ0EyT0JFbTFiUnRkUkVSNEFsdG9BM3FGRG5aZ3N0?=
 =?utf-8?B?VTEraFIvakdJZTgyUWZhYUZjVkJ0eEd4bStLMkRSVGlkK1ZuamxVcUJ6UEd6?=
 =?utf-8?B?VFprYkhPTEx1SVIwMEJUaFlYSVhndE4yczl4Q2VsZitLQXM1Y1RKcE9DS05N?=
 =?utf-8?B?M3dxSDdsRmZHL2x5RXRSeFNhaFRITjgwdzB1V2F0SkE1VVNkVHgxTC9kUU5h?=
 =?utf-8?B?K1FCUWQ2eFFHOWVvcy9BYktzVGkrMDJTVVlsUXA1TE02dGxFYmo1VjhySmxG?=
 =?utf-8?B?cmJDekN3M0x4UWFrNjdkeG4zZ0xCMkFxV1QrUUJzMXYxM2lCQmVOb1Mvbklk?=
 =?utf-8?B?TElXMUhjSUZ4OTZkVmlYSDdIUWFHZkIvSWZFTjJHTWd5QytMZGxTWkc1OUsy?=
 =?utf-8?B?MldzQjlsSVhDWE5tRUQwaE9zUHpRaFdGZktQeWNjbjIvR0RDTmVJSTdOQldx?=
 =?utf-8?B?VlJFTjlKUDJaQ0hla0JvZUUwWDE1bVNUb3NBekUwWFBmazd3aWhrN2RmVDJM?=
 =?utf-8?B?VHNwVzZWczZBVEozQUlxYmhkM01QZE4wdlYza0d2N1pKWEVuQkJIMmtvZVpV?=
 =?utf-8?B?Q0xyVnhONldZckhUbHQvVkN6YnJ5Q0hTN3dYUjlORVF6NTFGU2lXMFl3cUZN?=
 =?utf-8?B?UFlaeDQ2aG8yK3pXRUxsVjJFRFJQbXBudTF5YnllSVRhVU1GdXhscXp3aVNp?=
 =?utf-8?B?SXRJaXFDRjIzZ2NYTElwYVo3Yk8zVzVtWE9aczhITTV1MVdNc3FUYmJTMXp6?=
 =?utf-8?B?MVR5UTFtLy83cHJqRmt2MHQ5VG43ancrd3JuZXRBbEp1Wko0bWFWTG8xTlRw?=
 =?utf-8?B?TllQc2QrbTBiRmpVYnZOdklscjBRbzRIeXFKaUVPT1NwTW5jWTRFTE5EMk4y?=
 =?utf-8?B?YmNDeWo4T2dTVUNiZ1BXQUtkT1c3OHVMd0RBL2VweGNWdFZKU3hPekdhUytz?=
 =?utf-8?B?ZTlmVXRLU2dSemh4TVZwaWFhQWdESkt1U0h3akZYSm1GTDczcUQ0UWJrbWlk?=
 =?utf-8?B?aTk0aFo4WjBvdktSWlJOYnpFWkNJRTlaQ081eVdWeDIyWGpZRnFVVVVSUzZW?=
 =?utf-8?B?NUlwV1h0YXBkRnZ1ZlhxeGxXYVRPTURpL0xlcnZMektwaDlLMjFTMUpCZzVC?=
 =?utf-8?B?MG1WVERxb0svbExNMTdvTzhBOEZ6bW1ZaXdBSlNZeDY1Y1EvUzVqNEhKVFRI?=
 =?utf-8?B?MFp1K04xS3plQTltVTVTZnBMZFh4czRZK2t1NmdFSDFmbklCWnJ2OGNzZTF1?=
 =?utf-8?B?UDYwcjArVUFOR0llcjhSalRSN1QzNTZSUkpzZGJieEYwVzFIUWZZZFg3TnJQ?=
 =?utf-8?B?MnkyTk43b3F2bVlQUWtHaGtqWXVCakREclNHcHNGSnBGNjBnVjJYNi9NSUtr?=
 =?utf-8?B?VlFjZ0orQ1FnWFJpejcvWVBCY2dIQlUyaFNmSGdtV3pUR3BhOGhrVmNRTzFl?=
 =?utf-8?Q?XcLtIfTXL4WnjSOyWrwj9qA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90F9F10C70B00B44B7694FAC346A5331@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?utf-8?B?UjZxTEZ4djJtVzVyMGpET1J4RFd2dmJUd1pDOVZnNk5uMlVxaEhJak1TOTFo?=
 =?utf-8?B?NS91d2lYR0pwbFdTOG0vd3N5aktDTDBQaHhDQWNIN051cEprNHU5Z1lPRzNB?=
 =?utf-8?B?bzArZlQyL29NdlNBTzdtaXFja09UYThjNWdkdFpndnBVT2RseTB0QlB5NEMx?=
 =?utf-8?B?bDhxcHRuVFFCQmFoSk1aYjM2WVoxSjZFSCtmckdUYUFVa3VjUThSRUtvUFZP?=
 =?utf-8?B?T1FMWWFDd2tsakVleUpiWmVJYlAzSE9pYThaMEIrN2FIMlplUk5JVEl2UHBh?=
 =?utf-8?B?eXhoWGlaRFkrVW5RRktHRFBPSFN0bW1neVVDWjFHNjBkck5IRXREMUcvNHAw?=
 =?utf-8?B?WU94WVdabTJmZXZwS3d6WDV6ZlhkQkluU3hKWnBOWGI3dHdIMys0d1ZTZ2dj?=
 =?utf-8?B?UXhMRGpvNXRiYlpGYWRhbW9jRUo3K2dMWEE5TGdqV2pJSUMrMDlyTzVBdm1J?=
 =?utf-8?B?bEEyZkM0UDE1RzlhYTRqM2JYMzI2RC9RSTdzTVNROTRFbzU4U29wS3V0UUhl?=
 =?utf-8?B?Y0d3K1pvZ1VPVEtNNnVoNmlLMytwbVN6MStqUGxhU29McFlmblloazlLNUE4?=
 =?utf-8?B?dGhLb05vcnNpaWZRTGVkdkd0RDJyY2x3RkhXTWtReHI1SkhURDRCT1M4L083?=
 =?utf-8?B?b05QOFJ5dCtLQy9EdEgvVW5oQ0txc1Rta1ozYjY3Q0JIUjVRN2ZvU1ZZWHp6?=
 =?utf-8?B?TnUweEtzU2Jqa0RkcFJraE4yMjcxK2d3dGtwR2hVV1ZxQVFIaVpYdG1sSFho?=
 =?utf-8?B?YU9kNTB5OWhOWnBNZU1CUmEvWDh0US9jaDRmbzNFSkEzc2N4NXU4SmFOYnUz?=
 =?utf-8?B?eVp5MFhYZHMzM3hsalBXTDF1eWZZcFpiNjI4WitGWjl4ejJFSFU2RkgveHpW?=
 =?utf-8?B?aEZDVUl2MHREeGtpczdnajFYeTd1YWphNmR4b2lialdxV25BSzVuT28xR2VG?=
 =?utf-8?B?Zld3ZXV6dFV0dHJKakpTN1BvNUh3Sk9BTTZmd0xabHhodzJCVVVENDRBYnFt?=
 =?utf-8?B?Qm9WaTh0VEV0Vk5xWmJYNDNROWZPWXlkWi9uV3JDd1k5SGxrQWdxNmplOXIz?=
 =?utf-8?B?WCsrNDBUdE85bDB6SzdJZjY4ZEhMQ1plZlQvdkticVZSRXBidzQ3alFSSHM1?=
 =?utf-8?B?Yjkxc1pHQnpiUklYeWROdVhvVjh6K1FidEVBcjh1ZWN2aDI1QXdiT1A1UW5m?=
 =?utf-8?B?SUNnaTVjbHQ0VTRmN3Roa2puYUNmNkw4b1BubmhvcXBiRjNiMC9kaFNrS2Zo?=
 =?utf-8?B?QUFWbCtIRmRRWDdJMVFFMjhNbXdGOUVBcGwwWFYzM3gxbHBxQWtBbkhUSFNF?=
 =?utf-8?B?ZnBobzVuUTlESzdxSVZnT3o0NGRaQlVNNHU2bm8waTk5K3ROV0I0R1dBYU1m?=
 =?utf-8?B?Vk5ZVm14R3FxcWdnVUdRZUxXcHU0eTBwc2QwRkEwaGtETXIyd2toQWRZSm1R?=
 =?utf-8?Q?MoiIZcb0?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629410a6-af60-40cb-b671-08dbcf1cf719
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 14:25:51.4584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twFoV9aBqs90POkcjjtFTiFHoIDux99UMiEsr5P5WbQIzrnvyvif/vQKjbGt2uzChKwkBHXEprDkbi7qAsds2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5703
X-BESS-ID: 1697552756-103438-20950-64-1
X-BESS-VER: 2019.1_20231013.1615
X-BESS-Apparent-Source-IP: 104.47.58.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobm5kZAVgZQ0CTVItU0zdzQOD
	HZMiUtxSDZONU4KS3Z3NI4KSXJ1DJZqTYWAAN4PCZBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251504 [from 
	cloudscan22-50.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b
X-BESS-BRTS-Status:1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gMTAvMTEvMjMgMDk6MTcsIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IEhpIEJlcm5kLA0KPiAN
Cj4ga2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCB0aGUgZm9sbG93aW5nIGJ1aWxkIHdhcm5pbmdz
Og0KPiANCj4gaHR0cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dpdC1mb3JtYXQtcGF0Y2gjX2Jhc2Vf
dHJlZV9pbmZvcm1hdGlvbl0NCj4gDQo+IHVybDogICAgaHR0cHM6Ly9naXRodWIuY29tL2ludGVs
LWxhYi1sa3AvbGludXgvY29tbWl0cy9CZXJuZC1TY2h1YmVydC9mdXNlLXJlbmFtZS1mdXNlX2Ny
ZWF0ZV9vcGVuLzIwMjMwOTIxLTAxMzgwNQ0KPiBiYXNlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Zmcy9pZG1hcHBpbmcuZ2l0IGZvci1uZXh0DQo+
IHBhdGNoIGxpbms6ICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzA5MjAxNzM0NDUu
Mzk0MzU4MS01LWJzY2h1YmVydCU0MGRkbi5jb20NCj4gcGF0Y2ggc3ViamVjdDogW1BBVENIIHY5
IDQvN10gdmZzOiBPcHRpbWl6ZSBhdG9taWNfb3BlbigpIG9uIHBvc2l0aXZlIGRlbnRyeQ0KPiBj
b25maWc6IGkzODYtcmFuZGNvbmZpZy0xNDEtMjAyMzA5MjcgKGh0dHBzOi8vZG93bmxvYWQuMDEu
b3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIzMTAxMS8yMDIzMTAxMTEyNTkuV0dqWGF0NnAtbGtwQGlu
dGVsLmNvbS9jb25maWcpDQo+IGNvbXBpbGVyOiBnY2MtNyAoVWJ1bnR1IDcuNS4wLTZ1YnVudHUy
KSA3LjUuMA0KPiByZXByb2R1Y2U6IChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2Fy
Y2hpdmUvMjAyMzEwMTEvMjAyMzEwMTExMjU5LldHalhhdDZwLWxrcEBpbnRlbC5jb20vcmVwcm9k
dWNlKQ0KPiANCj4gSWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21t
aXQgKGkuZS4gbm90IGp1c3QgYSBuZXcgdmVyc2lvbiBvZg0KPiB0aGUgc2FtZSBwYXRjaC9jb21t
aXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWdzDQo+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0
ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiB8IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+IHwgQ2xvc2VzOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjMxMDExMTI1OS5XR2pYYXQ2cC1sa3BAaW50ZWwuY29tLw0KPiANCj4gTmV3
IHNtYXRjaCB3YXJuaW5nczoNCj4gZnMvbmFtZWkuYzozNDE4IGF0b21pY19yZXZhbGlkYXRlX29w
ZW4oKSB3YXJuOiB2YXJpYWJsZSBkZXJlZmVyZW5jZWQgYmVmb3JlIGNoZWNrICdnb3Rfd3JpdGUn
IChzZWUgbGluZSAzNDE0KQ0KPiANCj4gT2xkIHNtYXRjaCB3YXJuaW5nczoNCj4gZnMvbmFtZWku
YzoxNTczIGxvb2t1cF9kY2FjaGUoKSB3YXJuOiBwYXNzaW5nIHplcm8gdG8gJ0VSUl9QVFInDQo+
IGZzL25hbWVpLmM6MTY1OCBsb29rdXBfZmFzdCgpIHdhcm46IHBhc3NpbmcgemVybyB0byAnRVJS
X1BUUicNCj4gZnMvbmFtZWkuYzoyMTg5IGhhc2hfbmFtZSgpIGVycm9yOiB1bmluaXRpYWxpemVk
IHN5bWJvbCAnYmRhdGEnLg0KPiBmcy9uYW1laS5jOjI2MDAgX19rZXJuX3BhdGhfbG9ja2VkKCkg
d2FybjogaW5jb25zaXN0ZW50IHJldHVybnMgJyZwYXRoLT5kZW50cnktPmRfaW5vZGUtPmlfcndz
ZW0nLg0KPiBmcy9uYW1laS5jOjM0ODAgbG9va3VwX29wZW4oKSBlcnJvcjogdW5pbml0aWFsaXpl
ZCBzeW1ib2wgJ2Vycm9yJy4NCj4gDQo+IHZpbSArL2dvdF93cml0ZSArMzQxOCBmcy9uYW1laS5j
DQoNClRoYW5rcywgZml4ZWQgaW4gbXkgdjEwIGJyYW5jaCwuDQoNCg==

