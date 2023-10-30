Return-Path: <linux-fsdevel+bounces-1543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344AD7DBC81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 16:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC421F21910
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8F182C5;
	Mon, 30 Oct 2023 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="BqL3xPF2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFE6FAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 15:22:22 +0000 (UTC)
Received: from outbound-ip201a.ess.barracuda.com (outbound-ip201a.ess.barracuda.com [209.222.82.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341A4A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 08:22:17 -0700 (PDT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169]) by mx-outbound41-132.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 30 Oct 2023 15:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHdXRO/Qemh1stdWIJAHnnwBf0cKWDk0NIqyndKzL8URRKX37gvl/38oLH7QL4vSINR003fWUPOqWBIfbtiqjdrAZmDA7f1KhkPrQzujx240mM1bpgZNJYoAVknyAAupWgfrWpa8WbG0zFhxERtGmtdTHQ4/8/Eli4uVKRdliOIdYIBBtEVJInX9OxXszsxhF123NDwjK7xODplzlgv4t2ErvPqwPpqL5Ti90mE9C2Z92OaGoFl0GwmR7ecJf0c2r1pZ3b9nWkaMllSSC5dcxeMs9vueEtVcxTIrK3PLcNi67Gs9NayGbobyuTuM3SYeqhctX8w0XuYOTPks0rcBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoUw5BwrtBxpx9NM5bhrOuOZ3uLG2Hhbw8MWn16AH4M=;
 b=JlqO/MBJ3n3H/JyWJSk7rK5f4JWFSYUAufalU9JC04oU8N70PVniVXYe8mtfz5z/oKjFlTz3sTogIHcjgIgbpSX62zDgYlOVCPaRhu/g08F1mcB7Lk8Mvn63JmaflRtot/Nb6j8mxNrvZoxOIN+YItKAPTlH2PdSKe6rtp6KG6/10SmfZutzX+AB9MylHLIwE/LIMEoiAiaWW1BaB1SU2G+L1CipQzZTp/8/zPQoDaNMEvJwaCAjdretu6wUbjE+K9eSRKgAe9JuUiOSulmYvr2u9602cqAYVE+ChADYu02zu1RenYIeEyi+0fWPmJ/GG1Ln7mn2fw8zCJ8pNFjwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoUw5BwrtBxpx9NM5bhrOuOZ3uLG2Hhbw8MWn16AH4M=;
 b=BqL3xPF2244sBbD1DIAb50fCJqNI+RgEQdTWM1qWJK22JK+JcYk6g4y2u3EXhpqYIYgUi7poUQeMTQMa/Dzq4UIRzzN7GCIFzhvMA5gtJ4z68lvvWrQlObV06O0VwgRZbfajtCEfEVYUDsBQUwcYUy4wEBxvihp+1Y2b0pnVv9E=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by CH2PR19MB3830.namprd19.prod.outlook.com (2603:10b6:610:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 15:21:59 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6c5:73e5:6973:4351]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6c5:73e5:6973:4351%5]) with mapi id 15.20.6933.025; Mon, 30 Oct 2023
 15:21:58 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>, Dharmendra Singh <dsingh@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>, Christian Brauner
	<brauner@kernel.org>
Subject: Re: [PATCH v10 2/8] fuse: introduce atomic open
Thread-Topic: [PATCH v10 2/8] fuse: introduce atomic open
Thread-Index: AQHaBd8I6qRtt0H49k+Fa3llYfYRsrBeitIAgAPzE4A=
Date: Mon, 30 Oct 2023 15:21:58 +0000
Message-ID: <ebfd2fad-144a-400c-bf15-c6f07a20ff7c@ddn.com>
References: <20231023183035.11035-1-bschubert@ddn.com>
 <20231023183035.11035-3-bschubert@ddn.com> <20231028030310.GR800259@ZenIV>
In-Reply-To: <20231028030310.GR800259@ZenIV>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|CH2PR19MB3830:EE_
x-ms-office365-filtering-correlation-id: 7cb9ba80-9d7b-4e5e-6354-08dbd95bf546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vu36Dp6M5NYyMiacVLDxmgn/Xkvbq2HLmajwldAQy25hgN0av+VeFiTSEq9LCer1dYXs0yAnXNFTT2FvqZtdxAtj94fswv6YU31XiKb2M+wtZrwUFvAiGuXZVPZZweVIi3qBSIgCxyEDCxfsUQUCNqnf5U/rZ0ofmtFjHKhlmuqxODQuXzqJB0ni+jcHnKujtV+XTQwIUtF8VwI18MMfDqcrNTU09719wRQ2H+hjFtRiNn0QLaVo36lfzXwfsBdCy1MQkh0dfGVvxUWcFZGeBTKhSU7rboSmx/J1/Zk4C0k8YLdhYtRFIKcR2YuZSS2RIl/tA6+Eujgautkqfq5kdFEfpm6crAX1Qy50Za5KpN+kOFqsm0gxVKq2KmSU9qTKg5T/T3qRzAeAL2qzbLLiPpeXKFErP6J7Sp8ifm2lszDXUC/s/Nbg0g5HTwdh6Z7yJJsnK4G5r5j92SBvV4hSW78t/7vW/I4KO29xdbG+dVghRMs+fHTT+RtUH4OEG5jTeoCYNy4iYuKfxJxGVlrOSCKZWF24MXnCiQpO/N9QqGTzG7awQMophQH2Cur1O9HzukttFxt1RAyVjGu5qIlAbR7nwb9VnXpeK1F8ojWadHgYAlnJDL43jVOJLwYCNxeEXnQJGFXVhLfrTiH4Imbg5TW9pVo3lzJwf3b8m9M5XLrDQBw8rP33Ouu0c46qs1dRoRl76oryZlMVyhTGfm4LUw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(41300700001)(6506007)(53546011)(71200400001)(6512007)(6486002)(478600001)(83380400001)(2616005)(2906002)(5660300002)(54906003)(64756008)(66946007)(6916009)(66446008)(66476007)(66556008)(316002)(76116006)(91956017)(4326008)(38070700009)(8676002)(8936002)(86362001)(31696002)(36756003)(38100700002)(122000001)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1QrbHhJUWR3a0pCcDJyQmR3cHdwcEM4L1g3aTcrVXdjYjhuZjFtbVB2cyto?=
 =?utf-8?B?SHgrRU9wR0N4ZWVWVFRCOStibENTZmlmbzkzOE53bERTKzFCUDc1QVR5UUk0?=
 =?utf-8?B?ZHcyZk9NVjFSRzNyZmM4c210aWxvTmJ0T3BUWEk0V3V3Z0FHd3FLTGQ1aGxT?=
 =?utf-8?B?RmhHWGxDd01UeXp6Qzl1UHU5UDZVeTlFa2hIRlNCWnZ0NWlzbm03enk4NjQv?=
 =?utf-8?B?STZMV3dvL3pCYmRKamo3UldjOXlJLy9BZFdIUER6ZkF2ZTl0R1VTRTBrZUg4?=
 =?utf-8?B?cFA1NlAwQUVxQUJHUW5RUG9FV1VIVWVaekJyVWNXdE1QMXpHV0NvZGZmVWlI?=
 =?utf-8?B?TytwelB2S2MzcFd2Mm9jOUtOSlA5dXNQZHFrQ1puQng5M0Ivc0VXVmtqNXg1?=
 =?utf-8?B?d2wvZFI4YVQwaGR2M0NUMU5tRnRCc3dKd2lYV3NNcEhwUEwvNWJaVXNEc1JI?=
 =?utf-8?B?VkgydVVOQkZSUEhVVG5meTMxekJ1MW45cVlTNisvTmkvMG5EOEVKeGVQNTBW?=
 =?utf-8?B?elhzUTgzak1USGMxa0ZiY3hwbG5WRk1EY3ArNmJ3TzdUUXNTazYxbWxDRW1I?=
 =?utf-8?B?NXRSQVhOai9iSi9VUzNSZXUrdFJab0lOUHJocmppbkN6dDJlOUxaL3pCeFRk?=
 =?utf-8?B?MkJvWm5QUFVQYzNWSmhUZUZDaEpnekhaRmFWRDFmaFlPWlNmSzJxalVLbEhk?=
 =?utf-8?B?ZFNSN1kvSzlPY0pGMm5RcU1aM2wxcVRhV3RBckEwejNXY1B3VDU0YjE2TEVs?=
 =?utf-8?B?Vzh0VzkxMGs0VG9pOEcrRFZwZEg3RWkrNG4wWGNobnl1eGdEeElvb1dBbExC?=
 =?utf-8?B?WkpsZXZqSDNicThMRGNMUWwzMzhkT0VHMExPalRkdVYvbmVrcEV2OVlSQkZJ?=
 =?utf-8?B?RHhPUStoUWNRT0cvSmlrTXhhL0psUG5zL1lSajZHNEtpVnEzLy8walI3NnhQ?=
 =?utf-8?B?dmxGR2xlT2FYRTgwM1RMNmlKNmhUOXJmeGMwWWNqSFp1eXl3dE9GVHZCVGx0?=
 =?utf-8?B?TkhMT3BTU29weitwRTBxTUIrMURkeWV0eVJJMXB2RC8vTTFIT3BreTU3Tlh3?=
 =?utf-8?B?QWRVeUx1RzBSWkpUd3hnWU9iNG82LzViYi9EUzVaa05Xd01mcGtHeWNUMFdG?=
 =?utf-8?B?b01xVFNNNGczbU91N1pXbVk3WmdZbUFLRWxvOWRvbm5IUHpTaXpkV3NLQiti?=
 =?utf-8?B?cG1wOGdxeXpWUW5RcmI4cFpyRUxkVnBjd0NCeEtlcGM5eEVZRmR5R0l0MFhB?=
 =?utf-8?B?VjMrejhpMmpCL3paWm9NSk03dDBGKzdUa3N3bmE1K3NQVzVFMEFhNW1hb3pp?=
 =?utf-8?B?YWZHcE1CQjRoWXUvN1p4TmR0WXBXWDVTNEkvN2U3akppOVRBZStVdGNYaUN0?=
 =?utf-8?B?UWpCeXRKUjJTTGgrV2dVUDgwVHZuQ0tpSTB5SlNlQlhzSEQ2R1RsL00zNHlZ?=
 =?utf-8?B?dSs3cWd6elQ5Tk5qVjZVWVp3OHZKNWQ1djV2SjdvOEtRN3hyWUdYUFhWakF3?=
 =?utf-8?B?SlBPUUpHcXlMWTFoYWx5LythangwZ0lueUN6REJmbG1rbkJTeWxTSFVEUUpX?=
 =?utf-8?B?N1BEYzJtYzRFTUdGZDNDYWYxbWNOdTg3enpmNElvWUNmbzlEajBKSkpYU3B1?=
 =?utf-8?B?ZzN2L2JiNU9TV1JENGVEbnJTVHBKV3FBWFVOSWVHMjR5TnRGdTRpZ0hkNGxJ?=
 =?utf-8?B?dTcyZk5ERktoVTBUYjVEVjgvOUVnTU1lY2oxNGErb0FDbzFHQVQvN2pmbEZG?=
 =?utf-8?B?L0JNQWVaMUFEbkcySVVrT3RlZTBKWlRIWGwrWGt5ZzdoZU5MM0xMbnUwTzA3?=
 =?utf-8?B?VmlPTVpwSE5sdWF4bWR2UkpxaFltVkxoUjNPMENLK0Z6cjJtbHZ5ZDVob2JQ?=
 =?utf-8?B?L090b1JUeGJ0QlBkNmtXWGM2UGFCQ0VkemZ4Z3JjVjhnODhQWmhRUUZ5SzNI?=
 =?utf-8?B?UmRTT1dGRnRhSEtyMlB0TU1MSjVmSG1BVnhFSmxmdWJSYmRWSCtQbFpveDJH?=
 =?utf-8?B?ZjZFMHdONzY5S3pwNGo4MUI0THNpMWtCTDhxQmdMVW5DTm5LQTlveDBidFFi?=
 =?utf-8?B?eXBYSEhSSWpHcnF0Nmk0UXhybGNVU0lHZ3RpZzBNZ2NRdy9GcVBVcGYzU2Ft?=
 =?utf-8?B?Y2tWSTVTczJSdU5iYTVoaXIrMFQrdEtIVG13TDNva2JwV3lhV0FlQWg4R2Nk?=
 =?utf-8?Q?fHl0WWhepfV2NrRnB/0ZxTc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE7F4A63FCCF7B41818127E5C7FEC770@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?utf-8?B?dWRyMHJZdjZSZzdBeHNPajhHR2hDOTRwSFpEN2Z4c1Z1Z3RvOCtRSGpmbVBa?=
 =?utf-8?B?b3o4d2N2UmJZSGRHYmJvdnFOeXd4UGwzUnQzREhqd0QwWmNKdi93WFpzYkdC?=
 =?utf-8?B?ajNiM1RISTVyRlRGb0w0MFJpenFzMkxJWjN2OEJZdDZvY0JnaXkxOTlpQkdH?=
 =?utf-8?B?N0lha1l6ZCt4TmRySGlnQmlyYjcwNFBFRHRGeVJWQVJGK3lvN09GcnQ3STFR?=
 =?utf-8?B?TkhzL0tOd3ZYbmVLc3Y3dnFRUXkzaVVkcVQzdmhvaXd6NWNrL2g0b3dMdnFH?=
 =?utf-8?B?QmVpblQzNnorNnp1UFpGcTdRYjFQN0dxY2dDdk84YkZQelc1VXVITy9lbXpX?=
 =?utf-8?B?NCt3VXlZT25qbGd4MURnTTk1dVozTUgrcWlEQndZKzR1eE83OVRscWt4Ui90?=
 =?utf-8?B?WTRyS1lwSTZpUFFGd3ZKMTRVQ3ZlbVE4L2x5TzB2Tzc5Tk5ORnJPajR5MHh4?=
 =?utf-8?B?ZGlKSU1SS1BKNDBkckdkYmdQR2ZMZVppTjgzL2R0K3lLVnNKb1RWSlcwL2k0?=
 =?utf-8?B?TXpQNlB4UEpna2VTeThsMHl6VDM2OTl3dUt6YmNvUU9ORG1OVEttZ0pmaXh3?=
 =?utf-8?B?Z2l0U3RMUUoxTXlCT3dUc3VJNVZuVk1VSE1FUFcxdjJsUVd0bHl6QVBNcjFV?=
 =?utf-8?B?NENoZVE4OHl0ZjBQaVF0S0wxdUNyVFQrcW1XWVNpVE4xVVVNcmRFeU5Ub3lY?=
 =?utf-8?B?UWYrNVQ1L1ROVW1PeWNwTk45dWg0OURqakVaZ1lxMUlmeGRTOGxvcEVXZWFE?=
 =?utf-8?B?OTgrYVJ1WjNycUFUVnJvcE96Zm4rOVJDSjErVm93M2pJaVM1SjQ1QkNFbnpN?=
 =?utf-8?B?UlA3RTRpc0JsMGIwR0xFQy9rcG4zTHVsam1NeWZVU3QvY0JOL1Iwd0RoL0lh?=
 =?utf-8?B?N3dEcW9MY09TRW0rZnFYd25PQWdKSUJEc3RxVlFMdEU3VDlLZUk1S2NVdUhR?=
 =?utf-8?B?T2wzY1BxVFhDRHRhMGxkYk5HTmZHWVkwRkVSTENwdXM1dW9WWiswekZhT2xY?=
 =?utf-8?B?bVJRUXc2MzVXb3pPa2VNalM0SkJURVNPSmxxbVdSQjcydTNOU0xoSEVHOGYv?=
 =?utf-8?B?a0MvMEU5UXNHSzUxMGhBcTNjTG5KL2NndmVFZ3B5blg1RExWem5JcXBqU1hp?=
 =?utf-8?B?STJWZGRvZ1FJbWp3MC9YWXprNG44UHl3emp5b1Vvc05zZ0JsbG8vUXhDMjlD?=
 =?utf-8?B?UldqYjMzZi9xeTQraHZ3em12QTVid2JVdVdKVkVqaFQ3QytqTkJZemZNRkh5?=
 =?utf-8?Q?19lPzpKG5HLrzQ1?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb9ba80-9d7b-4e5e-6354-08dbd95bf546
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 15:21:58.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4UeOcQsHUJ4eQhQAdsdkOQ9G1cn6q/lAGRC8WbR8IFzojwu1CSCSm+b+PDuz6d/yJYeM1rwXyKA3MEGK3Lmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3830
X-BESS-ID: 1698679322-110628-12534-444-1
X-BESS-VER: 2019.1_20231024.1900
X-BESS-Apparent-Source-IP: 104.47.59.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYmBmZAVgZQMM3YMsnUwsAizT
	LZLCXRMiU1Nc3AxNTSONnSLNnQPM1IqTYWAMgFortBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251791 [from 
	cloudscan22-215.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

VGhhbmtzIGEgbG90IGZvciBhbGwgeW91ciByZXZpZXdzLCBBbCENCg0KT24gMTAvMjgvMjMgMDU6
MDMsIEFsIFZpcm8gd3JvdGU6DQo+IE9uIE1vbiwgT2N0IDIzLCAyMDIzIGF0IDA4OjMwOjI5UE0g
KzAyMDAsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPj4gK3sNCj4+ICsJaW50IGVycjsNCj4+ICsJ
c3RydWN0IGlub2RlICppbm9kZTsNCj4+ICsJRlVTRV9BUkdTKGFyZ3MpOw0KPj4gKwlzdHJ1Y3Qg
ZnVzZV9tb3VudCAqZm0gPSBnZXRfZnVzZV9tb3VudChkaXIpOw0KPj4gKwlzdHJ1Y3QgZnVzZV9j
b25uICpmYyA9IGZtLT5mYzsNCj4+ICsJc3RydWN0IGZ1c2VfZm9yZ2V0X2xpbmsgKmZvcmdldDsN
Cj4+ICsJc3RydWN0IGZ1c2VfY3JlYXRlX2luIGluYXJnOw0KPj4gKwlzdHJ1Y3QgZnVzZV9vcGVu
X291dCBvdXRvcGVuOw0KPj4gKwlzdHJ1Y3QgZnVzZV9lbnRyeV9vdXQgb3V0ZW50cnk7DQo+PiAr
CXN0cnVjdCBmdXNlX2lub2RlICpmaTsNCj4+ICsJc3RydWN0IGZ1c2VfZmlsZSAqZmY7DQo+PiAr
CXN0cnVjdCBkZW50cnkgKnN3aXRjaGVkX2VudHJ5ID0gTlVMTCwgKmFsaWFzID0gTlVMTDsNCj4+
ICsJREVDTEFSRV9XQUlUX1FVRVVFX0hFQURfT05TVEFDSyh3cSk7DQo+PiArDQo+PiArCS8qIEV4
cGVjdCBhIG5lZ2F0aXZlIGRlbnRyeSAqLw0KPj4gKwlpZiAodW5saWtlbHkoZF9pbm9kZShlbnRy
eSkpKQ0KPj4gKwkJZ290byBmYWxsYmFjazsNCj4+ICsNCj4+ICsJLyogVXNlcnNwYWNlIGV4cGVj
dHMgU19JRlJFRyBpbiBjcmVhdGUgbW9kZSAqLw0KPj4gKwlpZiAoKGZsYWdzICYgT19DUkVBVCkg
JiYgKG1vZGUgJiBTX0lGTVQpICE9IFNfSUZSRUcpDQo+PiArCQlnb3RvIGZhbGxiYWNrOw0KPiAN
Cj4gSG93IGNvdWxkIGl0IGdldCB0aGVyZSB3aXRoIHN1Y2ggbW9kZT8gIFdlIGNvdWxkIGNoZWNr
IHRoYXQNCj4gaW4gZnMvbmFtZWkuYzphdG9taWNfb3BlbigpICh3aXRoDQo+IAlpZiAoV0FSTl9P
Tl9PTkNFKChvcGVuX2ZsYWdzICYgT19DUkVBVCkgJiYgIVNfSVNSRUcobW9kZSkpKQ0KPiAJCWVy
cm9yID0gLUVJTlZBTDsgLy8gZm9yIHRoZSBsYWNrIG9mIEVXVEZBUkVZT1VTTU9LSU5HDQo+IAll
bHNlDQo+IAkJZXJyb3IgPSBkaXItPmlfb3AtPmF0b21pY19vcGVuKC4uLi4pDQo+IG9yIHNvbWV0
aGluZyBzaW1pbGFyKSwgYnV0IHRoYXQgZG9lc24ndCBiZWxvbmcgaW4gdGhlIG1ldGhvZCBpbnN0
YW5jZXMuDQo+IEFuZCBpdCByZWFsbHkgc2hvdWxkIG5ldmVyIGhhcHBlbiAtIHRoYXQgdGhpbmcg
Y29tZXMgZnJvbSBvcC0+bW9kZSBhbmQNCj4gd2UgaGF2ZSBidWlsZF9vcGVuX2ZsYWdzKCkgZG9p
bmcgdGhpczoNCj4gICAgICAgICAgaWYgKFdJTExfQ1JFQVRFKGZsYWdzKSkgew0KPiAgICAgICAg
ICAgICAgICAgIGlmIChob3ctPm1vZGUgJiB+U19JQUxMVUdPKQ0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICAgICAgICAgICAgICAgICAgb3AtPm1vZGUgPSBo
b3ctPm1vZGUgfCBTX0lGUkVHOw0KPiAgICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAg
ICAgIGlmIChob3ctPm1vZGUgIT0gMCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPiAgICAgICAgICAgICAgICAgIG9wLT5tb2RlID0gMDsNCj4gICAgICAgICAg
fQ0KPiBzby4uLiAgQXJlIG90aGVyIGluc3RhbmNlcyBkb2luZyB0aGUgc2FtZSBraW5kIG9mIHBh
cmFub2lhPyAgVGhhdCBCVUdfT04oKQ0KPiBpbiBjdXJyZW50IGZ1c2VfYXRvbWljX29wZW4oKSBp
cyBib2d1cyAoYW5kIHNlcmlvdXNseSBtaXNwbGFjZWQpLi4uDQoNCk9rLCBzb3JyeSwgd2UgdG9v
ayBvdmVyIHRoZSBjaGVjayBibGluZGx5LiBJIGFkZGVkIGFub3RoZXIgcGF0Y2ggaW4gdGhlIA0K
djExIGJyYW5jaCB0byByZW1vdmUgdGhlIEJVR19PTiBpbiBjdXJyZW50IGZ1c2VfYXRvbWljX29w
ZW4uDQoNCj4gDQo+PiArCWZvcmdldCA9IGZ1c2VfYWxsb2NfZm9yZ2V0KCk7DQo+PiArCWVyciA9
IC1FTk9NRU07DQo+PiArCWlmICghZm9yZ2V0KQ0KPj4gKwkJZ290byBvdXRfZXJyOw0KPj4gKw0K
Pj4gKwllcnIgPSAtRU5PTUVNOw0KPj4gKwlmZiA9IGZ1c2VfZmlsZV9hbGxvYyhmbSk7DQo+PiAr
CWlmICghZmYpDQo+PiArCQlnb3RvIG91dF9wdXRfZm9yZ2V0X3JlcTsNCj4+ICsNCj4+ICsJaWYg
KCFmYy0+ZG9udF9tYXNrKQ0KPj4gKwkJbW9kZSAmPSB+Y3VycmVudF91bWFzaygpOw0KPj4gKw0K
Pj4gKwlmbGFncyAmPSB+T19OT0NUVFk7DQo+PiArCW1lbXNldCgmaW5hcmcsIDAsIHNpemVvZihp
bmFyZykpOw0KPj4gKwltZW1zZXQoJm91dGVudHJ5LCAwLCBzaXplb2Yob3V0ZW50cnkpKTsNCj4+
ICsJaW5hcmcuZmxhZ3MgPSBmbGFnczsNCj4+ICsJaW5hcmcubW9kZSA9IG1vZGU7DQo+PiArCWlu
YXJnLnVtYXNrID0gY3VycmVudF91bWFzaygpOw0KPj4gKw0KPj4gKwlpZiAoZmMtPmhhbmRsZV9r
aWxscHJpdl92MiAmJiAoZmxhZ3MgJiBPX1RSVU5DKSAmJg0KPj4gKwkgICAgIShmbGFncyAmIE9f
RVhDTCkgJiYgIWNhcGFibGUoQ0FQX0ZTRVRJRCkpIHsNCj4+ICsJCWluYXJnLm9wZW5fZmxhZ3Mg
fD0gRlVTRV9PUEVOX0tJTExfU1VJREdJRDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlhcmdzLm9wY29k
ZSA9IEZVU0VfT1BFTl9BVE9NSUM7DQo+PiArCWFyZ3Mubm9kZWlkID0gZ2V0X25vZGVfaWQoZGly
KTsNCj4+ICsJYXJncy5pbl9udW1hcmdzID0gMjsNCj4+ICsJYXJncy5pbl9hcmdzWzBdLnNpemUg
PSBzaXplb2YoaW5hcmcpOw0KPj4gKwlhcmdzLmluX2FyZ3NbMF0udmFsdWUgPSAmaW5hcmc7DQo+
PiArCWFyZ3MuaW5fYXJnc1sxXS5zaXplID0gZW50cnktPmRfbmFtZS5sZW4gKyAxOw0KPj4gKwlh
cmdzLmluX2FyZ3NbMV0udmFsdWUgPSBlbnRyeS0+ZF9uYW1lLm5hbWU7DQo+PiArCWFyZ3Mub3V0
X251bWFyZ3MgPSAyOw0KPj4gKwlhcmdzLm91dF9hcmdzWzBdLnNpemUgPSBzaXplb2Yob3V0ZW50
cnkpOw0KPj4gKwlhcmdzLm91dF9hcmdzWzBdLnZhbHVlID0gJm91dGVudHJ5Ow0KPj4gKwlhcmdz
Lm91dF9hcmdzWzFdLnNpemUgPSBzaXplb2Yob3V0b3Blbik7DQo+PiArCWFyZ3Mub3V0X2FyZ3Nb
MV0udmFsdWUgPSAmb3V0b3BlbjsNCj4+ICsNCj4+ICsJaWYgKGZsYWdzICYgT19DUkVBVCkgew0K
Pj4gKwkJZXJyID0gZ2V0X2NyZWF0ZV9leHQoJmFyZ3MsIGRpciwgZW50cnksIG1vZGUpOw0KPj4g
KwkJaWYgKGVycikNCj4+ICsJCQlnb3RvIG91dF9mcmVlX2ZmOw0KPj4gKwl9DQo+PiArDQo+PiAr
CWVyciA9IGZ1c2Vfc2ltcGxlX3JlcXVlc3QoZm0sICZhcmdzKTsNCj4+ICsJZnJlZV9leHRfdmFs
dWUoJmFyZ3MpOw0KPj4gKwlpZiAoZXJyID09IC1FTk9TWVMgfHwgZXJyID09IC1FTE9PUCkgew0K
Pj4gKwkJaWYgKHVubGlrZWx5KGVyciA9PSAtRU5PU1lTKSkNCj4+ICsJCQlmYy0+bm9fb3Blbl9h
dG9taWMgPSAxOw0KPj4gKwkJZ290byBmcmVlX2FuZF9mYWxsYmFjazsNCj4+ICsJfQ0KPj4gKw0K
Pj4gKwlpZiAoIWVyciAmJiAhb3V0ZW50cnkubm9kZWlkKQ0KPj4gKwkJZXJyID0gLUVOT0VOVDsN
Cj4+ICsNCj4+ICsJaWYgKGVycikNCj4+ICsJCWdvdG8gb3V0X2ZyZWVfZmY7DQo+PiArDQo+PiAr
CWVyciA9IC1FSU87DQo+PiArCWlmIChpbnZhbGlkX25vZGVpZChvdXRlbnRyeS5ub2RlaWQpIHx8
IGZ1c2VfaW52YWxpZF9hdHRyKCZvdXRlbnRyeS5hdHRyKSkNCj4+ICsJCWdvdG8gb3V0X2ZyZWVf
ZmY7DQo+PiArDQo+PiArCWZmLT5maCA9IG91dG9wZW4uZmg7DQo+PiArCWZmLT5ub2RlaWQgPSBv
dXRlbnRyeS5ub2RlaWQ7DQo+PiArCWZmLT5vcGVuX2ZsYWdzID0gb3V0b3Blbi5vcGVuX2ZsYWdz
Ow0KPj4gKwlpbm9kZSA9IGZ1c2VfaWdldChkaXItPmlfc2IsIG91dGVudHJ5Lm5vZGVpZCwgb3V0
ZW50cnkuZ2VuZXJhdGlvbiwNCj4+ICsJCQkgICZvdXRlbnRyeS5hdHRyLCBBVFRSX1RJTUVPVVQo
Jm91dGVudHJ5KSwgMCk7DQo+PiArCWlmICghaW5vZGUpIHsNCj4+ICsJCWZsYWdzICY9IH4oT19D
UkVBVCB8IE9fRVhDTCB8IE9fVFJVTkMpOw0KPj4gKwkJZnVzZV9zeW5jX3JlbGVhc2UoTlVMTCwg
ZmYsIGZsYWdzKTsNCj4+ICsJCWZ1c2VfcXVldWVfZm9yZ2V0KGZtLT5mYywgZm9yZ2V0LCBvdXRl
bnRyeS5ub2RlaWQsIDEpOw0KPj4gKwkJZXJyID0gLUVOT01FTTsNCj4+ICsJCWdvdG8gb3V0X2Vy
cjsNCj4+ICsJfQ0KPj4gKw0KPj4gKwkvKiBwcmV2ZW50IHJhY2luZy9wYXJhbGxlbCBsb29rdXAg
b24gYSBuZWdhdGl2ZSBoYXNoZWQgKi8NCj4+ICsJaWYgKCEoZmxhZ3MgJiBPX0NSRUFUKSAmJiAh
ZF9pbl9sb29rdXAoZW50cnkpKSB7DQo+IA0KPiAuLi4gaW4gd2hpY2ggY2FzZSBpdCBoYXMganVz
dCBwYXNzZWQgLT5kX3JldmFsaWRhdGUoKS4uLg0KDQpXaXRoIHRoZSBmb2xsb3cgdXAgcGF0Y2hl
cyB0aGF0IHJldmFsaWRhdGUgaXMgZ29pbmcgdG8gYmUgbW92ZWQgdG8gdGhpcyANCmZ1bmN0aW9u
Lg0KSXMgdGhlcmUgYW55dGhpbmcgaGVyZSB0aGF0IG5lZWRzIHRvIGJlIGltcHJvdmVkPyBJIGhh
ZCBhZGRlZCB0aGF0IGNoZWNrIA0KYWZ0ZXIgbG9va2luZyB0aHJvdWdoIHRoZSBvdGhlciBhdG9t
aWNfb3BlbiBtZXRob2RzIGFuZCB0aGVuIG5vdGljZWQgDQp5b3VyIGNvbW1pdCBjOTRjMDk1MzVj
NGQ6DQpuZnNfYXRvbWljX29wZW4oKTogcHJldmVudCBwYXJhbGxlbCBuZnNfbG9va3VwKCkgb24g
YSBuZWdhdGl2ZSBoYXNoZWQNCg0KDQo+IA0KPj4gKwkJZF9kcm9wKGVudHJ5KTsNCj4+ICsJCXN3
aXRjaGVkX2VudHJ5ID0gZF9hbGxvY19wYXJhbGxlbChlbnRyeS0+ZF9wYXJlbnQsDQo+PiArCQkJ
CQkJICAgJmVudHJ5LT5kX25hbWUsICZ3cSk7DQo+PiArCQlpZiAoSVNfRVJSKHN3aXRjaGVkX2Vu
dHJ5KSkgew0KPj4gKwkJCWVyciA9IFBUUl9FUlIoc3dpdGNoZWRfZW50cnkpOw0KPj4gKwkJCXN3
aXRjaGVkX2VudHJ5ID0gTlVMTDsNCj4+ICsJCQlnb3RvIG91dF9mcmVlX2ZmOw0KPiANCj4gbGVh
a2VkIGlub2RlPw0KDQpZaWtlcywgc2lsbHkgbWUgYW5kIHdpdGggdGhhdCBhbHNvIGxlYWtlZCBm
dXNlIHVzZXJzcGFjZSBpbm9kZS4NCg0KPiANCj4+ICsJCX0NCj4+ICsNCj4+ICsJCWlmICh1bmxp
a2VseSghZF9pbl9sb29rdXAoc3dpdGNoZWRfZW50cnkpKSkgew0KPj4gKwkJCS8qIGZhbGwgYmFj
ayAqLw0KPj4gKwkJCWRwdXQoc3dpdGNoZWRfZW50cnkpOw0KPj4gKwkJCXN3aXRjaGVkX2VudHJ5
ID0gTlVMTDsNCj4+ICsJCQlnb3RvIGZyZWVfYW5kX2ZhbGxiYWNrOw0KPiANCj4gZGl0dG8sIGFu
ZCBJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIHdoYXQgdGhlIGhlbGwgaXMgZ29pbmcgb24gd2l0
aA0KPiBkZW50cnkgcmVmZXJlbmNlcyBoZXJlLiAgV2hhdCBpcyB0aGUgaW50ZW5kZWQgYmVoYXZp
b3VyIGluIHRoYXQgY2FzZT8NCg0KDQpUaGUgaWRlYSB3YXMgdG8gZ2l2ZSB1cCAnc3dpdGNoZWRf
ZW50cnknIGFuZCBsZXQgdGhlIGV4aXN0aW5nIA0KZnVzZV9jcmVhdGVfb3BlbiBkbyB0aGUgZmFs
bGJhY2sgd29yay4gSG1tLCB5ZWFoLCBhbHJlYWR5IGNhbGxlZCANCmRfZHJvcChkZW50cnkpLiBB
bmQgaXQgYWxzbyBhbHJlYWR5IGRpZCB0aGUgdXNlcnNwYWNlIHBhcnQgLSBmYWxsYmFjayANCndp
dGhvdXQgZnVzZS1mb3JnZXQgaXMgdG90YWxseSB3cm9uZy4NCkkgZ3Vlc3MgSSBuZWVkIHNldmVy
ZSBwYXRjaCB1cGRhdGUgYmVjYXVzZSBvZiB0aGlzIC0gdGhlIG90aGVyIHBhcnRzIGFyZSANCm5v
dCBkaWZmaWN1bHQsIGJ1dCBoZXJlIGl0IGdldHMgY29tcGxleC4NCg0KPiANCj4+ICsJCX0NCj4+
ICsNCj4+ICsJCWVudHJ5ID0gc3dpdGNoZWRfZW50cnk7DQo+PiArCX0NCj4+ICsNCj4+ICsJaWYg
KGRfcmVhbGx5X2lzX25lZ2F0aXZlKGVudHJ5KSkgew0KPj4gKwkJZF9kcm9wKGVudHJ5KTsNCj4+
ICsJCWFsaWFzID0gZF9leGFjdF9hbGlhcyhlbnRyeSwgaW5vZGUpOw0KPiANCj4gV2hhdCBjYXNl
IGlzIHRoYXQgYWJvdXQ/ICAiV2UgaGF2ZSBhbiB1bmhhc2hlZCBwb3NpdGl2ZSBkZW50cnkgd2l0
aCB0aGF0DQo+IGV4YWN0IG5hbWUsIHBhcmVudCBhbmQgaW5vZGUiPyAgV2hlcmUgd291bGQgaXQg
aGF2ZSBjb21lIGZyb20/DQoNClNvcnJ5LCB0YWtlbiBmcm9tIF9uZnM0X29wZW5fYW5kX2dldF9z
dGF0ZSBhbmQgSSB3YXNuJ3Qgc3VyZSBpZiBpdCBpcyANCm5lZWRlZC4gQSBiaXQgbGFtZSBleGN1
c2UsIGJ1dCBORlMgaXMgdGhlIG9ubHkgb3RoZXIgZmlsZSBzeXN0ZW0gSSBmb3VuZCANCnRoYXQg
aGFuZGxlcyAhT19DUkVBVC4gSSBkZWZpbml0ZWx5IHNob3VsZCBoYXZlIG1hcmtlZCBpdCB3aXRo
IHNvbWV0aGluZyANCmxpa2UgLyogWFhYIGlzIHRoaXMgcmVhbGx5IG5lZWRlZCwgZnJvbSBfbmZz
NF9vcGVuX2FuZF9nZXRfc3RhdGUgKi8NCg0KPiANCj4gQW5vdGhlciB0aGluZzogdGhpcyBkb2Vz
IG5vdCBjb25zdW1lIGFuIGlub2RlIHJlZmVyZW5jZSwgbm8gbWF0dGVyIHdoYXQNCj4gZ2V0cyBy
ZXR1cm5lZCwNCj4gDQo+PiArCQlpZiAoIWFsaWFzKSB7DQo+PiArCQkJYWxpYXMgPSBkX3NwbGlj
ZV9hbGlhcyhpbm9kZSwgZW50cnkpOw0KPiANCj4gYnV0IHRoYXQgb25lICpkb2VzKiBjb25zdW1l
IHRoZSBpbm9kZSByZWZlcmVuY2U7IG5vdGUgdGhlIGlncmFiKCkgaW4NCj4gbmZzNCBjb2RlIHdo
ZXJlIHlvdSd2ZSBuaWNrZWQgdGhhdCBmcm9tLi4uDQo+IA0KPj4gKwkJCWlmIChJU19FUlIoYWxp
YXMpKSB7DQo+PiArCQkJCS8qDQo+PiArCQkJCSAqIENsb3NlIHRoZSBmaWxlIGluIHVzZXIgc3Bh
Y2UsIGJ1dCBkbyBub3QgdW5saW5rIGl0LA0KPj4gKwkJCQkgKiBpZiBpdCB3YXMgY3JlYXRlZCAt
IHdpdGggbmV0d29yayBmaWxlIHN5c3RlbXMgb3RoZXINCj4+ICsJCQkJICogY2xpZW50cyBtaWdo
dCBoYXZlIGFscmVhZHkgYWNjZXNzZWQgaXQuDQo+PiArCQkJCSAqLw0KPj4gKwkJCQlmaSA9IGdl
dF9mdXNlX2lub2RlKGlub2RlKTsNCj4gDQo+IC4uLiBzbyB0aGlzIGlzIGFza2luZyBmb3IgVUFG
Lg0KDQpZZWFoLCBhbmQgc3RhcmluZyBhdCBpdCBhZ2FpbiwgdGhlIGJlbG93IGZ1c2VfcXVldWVf
Zm9yZ2V0IGlzIG5vdCByaWdodCANCmVpdGhlciwgYXMgdGhhdCBpcyBhbHJlYWR5IGhhbmRsZWQg
dGhyb3VnaCB0aGUgaW5vZGUgcmVmZXJlbmNlIC8gDQotPmV2aWN0X2lub2RlLg0KDQo+IA0KPj4g
KwkJCQlmdXNlX3N5bmNfcmVsZWFzZShmaSwgZmYsIGZsYWdzKTsNCj4+ICsJCQkJZnVzZV9xdWV1
ZV9mb3JnZXQoZm0tPmZjLCBmb3JnZXQsIG91dGVudHJ5Lm5vZGVpZCwgMSk7DQo+PiArCQkJCWVy
ciA9IFBUUl9FUlIoYWxpYXMpOw0KPj4gKwkJCQlnb3RvIG91dF9lcnI7DQo+PiArCQkJfQ0KPj4g
KwkJfQ0KPj4gKw0KPj4gKwkJaWYgKGFsaWFzKQ0KPj4gKwkJCWVudHJ5ID0gYWxpYXM7DQo+PiAr
CX0NCj4gDQo+IC4uLiBhbmQgaGVyZSB3ZSBoYXZlIG5vIHdheSB0byB0ZWxsIGlmIGlub2RlIG5l
ZWRzIHRvIGJlIGRyb3BwZWQuDQoNCkkgZ3Vlc3MgSSBjb3VsZCBzb2x2ZSB0aGlzIHdpdGggYW5v
dGhlciB2YXJpYWJsZSwgYnV0IG1heWJlIHRoZXJlIGlzIGEgDQptb3JlIGJlYXV0aWZ1bCB3YXku
IEkgZmlyc3QgbmVlZCB0byB0aGluayBhYm91dCB0aGUgDQohZF9pbl9sb29rdXAoc3dpdGNoZWRf
ZW50cnkpLg0KDQoNClRoYW5rcyBhZ2FpbiBzbyBtdWNoIGZvciB5b3VyIHJldmlld3MsDQpCZXJu
ZA0KDQo=

