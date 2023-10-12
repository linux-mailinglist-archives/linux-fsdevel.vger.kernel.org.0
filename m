Return-Path: <linux-fsdevel+bounces-198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D197C777B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 21:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A922B1C2110D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931203C6A5;
	Thu, 12 Oct 2023 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MO2uI2mP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245B28E16;
	Thu, 12 Oct 2023 19:56:02 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23601B7;
	Thu, 12 Oct 2023 12:56:01 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CIAhMJ029785;
	Thu, 12 Oct 2023 12:56:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : mime-version; s=s2048-2021-q4;
 bh=zNSQOKmij6heabehQLoMl6vsr+Qe7vs70ugGnLsQSMo=;
 b=MO2uI2mPeL99aZ2RXmxF6CIcUct47EbnbbYCsyD0+YBcs1t6glXahLyhMPMeWKSqNm7L
 ITnqJ0XvJ0SGgI1/Hcrb+cv1CF3KUi5QihHz9kdJk1ObwsCBhtqwL7Km0w5Ssp9nXYuO
 D30670MA2Sj6XZhITgnlGfz+CbLRRTTGqm1+avqXr78j82ygTWZNo0xLJfZujSqbhkGB
 PGrF2vH7gmb6yBZhdk4MEewmi/vVnznQIXrx13hfzhpgPwHxXicEX5lR0w4+GKDFVHr+
 SVq53bnYT118DciJhl7TTi6QQUk48bZuDdDkpudJ6w+ATt95Su7MBnwXlHIRBgi+Olc3 Fw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tpbryr513-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 12:56:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dcw8NOdGfd+UCFP5RaKk50sg0MlC62v/cWIDaVCceILXGvyLmkzsDCgpA675E/H8watl+xmKW1f9RxE9vUoSSTZzvcMOYjNp2+erw9mVB8Uqm9I9lmdtrI8R2Ejlz77cqJtXl6+12+I8KRt2wL8dc1Uf5apMZQh7ecLySGtkrQ1bRktTfRgu6rOC5CuRUsHyPHLJIccKcVd4powhmbmRFAwaf5kpp+oqhM7Zh2NV39X1KHqSWGYksV/sfH8xwJAP17UCyCeVTCtdYbi7IQYbIx+QQT0N//au1uFTgJ4A6JDGIn892ldfvkir0XuW8w5iVtNc5SlYjFw+VF4vrfyQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNSQOKmij6heabehQLoMl6vsr+Qe7vs70ugGnLsQSMo=;
 b=JHBcFXK6iYsFg6/cARIwtBiazCr7nGpx36MfQuNJ3KZ1RFwf0GwLwu1CC1wJafNhsMxsk4cmzdkqf0hFETj5LzHr6x7mHS7vTfcFyZkcNIJxYha03tAL/uhId8OWMkBwloH0It6zE33ladHHIxmz2pvq0yiYQ5EWclfyVGOGxg91OoRMUB1CzCOagSrRoDbM2w+HA5JLLL9v2PM6fNaWccFBekJUP5cAB4HbpY4NUJjja6zO8I/pXzS8j47DjAB8SNk2ow8x1nOncEJrgQ9Skt+xetW589V3DxPjlT5MEFrgFYGsWKnDwWykHxEJb6AApK2cAzGdYNFBCTdq4H/0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by DM6PR15MB3829.namprd15.prod.outlook.com (2603:10b6:5:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 19:55:55 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::60e6:62d8:ca42:402f]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::60e6:62d8:ca42:402f%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 19:55:55 +0000
From: Nick Terrell <terrelln@meta.com>
To: Kees Cook <keescook@chromium.org>
CC: Nick Terrell <terrelln@meta.com>, Eric Biggers <ebiggers@kernel.org>,
        Nick
 Terrell <terrelln@meta.com>,
        syzbot
	<syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com>,
        Chris Mason
	<clm@meta.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com"
	<josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: Re: [syzbot] [zstd] UBSAN: array-index-out-of-bounds in
 FSE_decompress_wksp_body_bmi2
Thread-Topic: [syzbot] [zstd] UBSAN: array-index-out-of-bounds in
 FSE_decompress_wksp_body_bmi2
Thread-Index: AQHZ+WIW2tZXKI1VfkS0RwXdr6keRLBBuYeAgATf4AA=
Date: Thu, 12 Oct 2023 19:55:55 +0000
Message-ID: <19E42116-8FE3-4C4B-8D26-E9B47B0B9AC5@meta.com>
References: <00000000000049964e06041f2cbf@google.com>
 <20231007210556.GA174883@sol.localdomain> <202310091025.4939AEBC9@keescook>
In-Reply-To: <202310091025.4939AEBC9@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|DM6PR15MB3829:EE_
x-ms-office365-filtering-correlation-id: a9f60fb9-a1df-4ca1-6689-08dbcb5d3eef
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2kwbMpW6/FRzkS9c9wY7hImNSsbKtlgMJ0wpfz5esyJNPLZgDAOPyON9AVi6X5Daip8PskyGLza3W7/vxCzqtIbXo4k7OmlOcPQ710lNoz6TcNlksfIQdXtA/XvOQ7DnDqjV4s2lplU3kGfNa7H7MpbPT9nfngVtZANM9w0eFepe1IJLa+abi67qnBKtGrgcEGFc0UBFDN4Tt+TPadBaoinujR5az0bp1XJCwm6uKBzzeKqlo0O0JTwsUp90jBA1RyLFMYW1szKm7zvv06J2qZBC2hht8yk+cZ6ZsEX4oS2UBcF86TmoKObZk1suj4dHWlJZ+Q+gwNXJMXRrlkbXcXfswVhLK+l7JFHBlPbtX+MtXeN/cgQusbeJLtBzZlql1QUk7DfksxJBno5YyVdDSwLzSQQNtuKXpgyrM9+DXan9BlE155tsbX3aAOXcOXFH6/b1lxRNE1b6AtbEdUBGUwTQT8pwXVJAoF2gzFMtHuJGEV5OvELdXxc5iOfqhSMTJ9RzZBvRHNjG4NRUt7HTHUcXb2ziHiqtc3ZMKf1KEzn5KJyvS0C2tALy93V8JsFpN9h6beDMHZf5EnfFQaqcx5rHI+/+GcA6xtHaBZDx6mL/wuYPf22w3iRPGpDPbdzi8801sfIwuhPNpFjJZ+cMEw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(7416002)(71200400001)(2906002)(6486002)(966005)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(66556008)(76116006)(66446008)(66476007)(54906003)(64756008)(91956017)(66946007)(316002)(6916009)(36756003)(83380400001)(33656002)(6506007)(2616005)(6512007)(122000001)(38100700002)(38070700005)(86362001)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?aEkfsEurJJsKUKsGcZseVb0D1StzbuThw5CneQUuWKmC0e2XoAxgbd95yRXy?=
 =?us-ascii?Q?ozFuGqHQWuySrKCXmHyuJfJ9dJEoJikkIiGlkrf1Cp+1+tG/1zuxEIel9Uqm?=
 =?us-ascii?Q?nxS6ukw4E4NbbA5snPQGFQa82va9E9zhxc0qQGSZLGZlVljv19Xfeoz1ezL9?=
 =?us-ascii?Q?FbCKiX/ITdroTpKbRGibqo8yD9pff5jdLP2T6NYBlOQgaD7Go/7GnBID+t7W?=
 =?us-ascii?Q?UEajBBONvI2IgOL7ViJaVyemorIXNd1DeUPMH/y52jO9RMQeEkDjBVRzyYZV?=
 =?us-ascii?Q?lQV5pDq9bjCknUTQU1BkSln5hxcI+NAXiFhduN8ZD8ouVefEKqKMW6x1ocPZ?=
 =?us-ascii?Q?eOaunaVYIFqE1oMZB8YKafn1Wivb2MaWWzL6c/Ug0v4plZe/47RnFN5ViWPQ?=
 =?us-ascii?Q?lal9FxUC0f5dEKurYuYfhI6+86SPX/Mn7zctazo/SShDQJuyoKfR7DDYxzeK?=
 =?us-ascii?Q?Yq0hRA/PZjzhv+4hSiaqe+W8rdeDl6NwOrjsBibSo25oPHZ5Dp3H4ACmSebL?=
 =?us-ascii?Q?dCPjVpAWV9brO7zb9lGkaygcFWmLHBsExupPE9zyM8sy6ac+gRRpFsogV3mY?=
 =?us-ascii?Q?Sn9AFv9/m+pTW3XieLQgh3hcbq7e3dO93dmTFJnBDeojyxtEBJnjfdbtE8R0?=
 =?us-ascii?Q?zwERTkY0f6+2Hw3EWi0aUoek96AQ39T2Chw001B4MDLSzJ9AHO1tIsued6DH?=
 =?us-ascii?Q?HLv9AZYRW9ywMURwO/ErpiD+0tJSaAG4J/VZ6VCS2aSg3aqP8bEvIJLgND4k?=
 =?us-ascii?Q?tHvBt96PdFr6g3ZwMVOFd0SJ1WYlYtk+vfMG6Hqu0+u5mLFR0Fy/ouqI0Y36?=
 =?us-ascii?Q?khNuyiwtb1WHBKZk0vnksWo+UwKVQF/duyaPXhnQd7nOaXy12zDnx17Y5TkD?=
 =?us-ascii?Q?OSlf7WOPZFj+DZPPva3ilA0/fsoIcypKTSjG6BkUTZhcupuWqoDkB70KObt6?=
 =?us-ascii?Q?fJiSBMSlFtCFJXe4AzpwdekI2SgOZljKzQxrt0WqU00gstB9SCdIRDig1IWB?=
 =?us-ascii?Q?KfNf+K1ucU1AJrGin3OGZbrzAY4nypJ3emn2djVvwqTax/m2hLko8YnWaz3c?=
 =?us-ascii?Q?flv28El45SbNvplfAf02gfJQxhcjB7gkUgca8wkHRNhpilsiCZumoUlAlSyQ?=
 =?us-ascii?Q?cKtTTo9kcgU+wEBxs0A20lbih4iA9QxpjoEI8sBfzI0WqMioTc79WW7UnAqo?=
 =?us-ascii?Q?lnecbblph8yyEuvPBWJdWFXsOhzclGZP40Nt3UV+RH92P9WaXpZ+uqkSTMv/?=
 =?us-ascii?Q?N41kTGzgWxj0N8CRl8bUd5nn3+qU+fLVTWkr+b6jmRfw89j1J77HkGjvrzYU?=
 =?us-ascii?Q?CbfoUGu6JxLrCSA6RlNoVwnEMy41mpTqBQMV6speB9w18fu4SyFUJFBLyJuU?=
 =?us-ascii?Q?hK1yVA3oqzlFz+sL43mp4IxpLLFN8W0pL/LqF/ICQReWm6W7tTMmTi8WWxRi?=
 =?us-ascii?Q?tx0p9fb7SeVYqN0vc9O2fdZJn/fe7sl9Crhr/Acy/QdNk/wz6bTv5r8khjRX?=
 =?us-ascii?Q?A863cBFwa/W32G7wJrZiKIa3Zliq280GSeTKhYmWRKFGYPVmO1ZmoX/OIzAx?=
 =?us-ascii?Q?YzuEdytX2lS/QOPt7IdL4mpLmDaxqj1rQK49WlqjDTP/dKb109Wo4/OdaMuO?=
 =?us-ascii?Q?NepG8oiH/GiUdRB7u6uWWF0=3D?=
Content-ID: <7542183AE913FF4DBE5D0A19ECBBEDE0@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f60fb9-a1df-4ca1-6689-08dbcb5d3eef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 19:55:55.1054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD4zjJgj6ejthvuJANh1CRLLKftfioD657Wg/DG4nQHqMpMsHbmEq2oSaKW8CRVufEUq5y+smlxkM9rzQ3BiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3829
X-Proofpoint-GUID: pX3tiQ7Tk0GZIHmH1y2NVmCMh-0Xhwf2
X-Proofpoint-ORIG-GUID: pX3tiQ7Tk0GZIHmH1y2NVmCMh-0Xhwf2
Content-Type: text/plain; charset="us-ascii"
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_12,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Oct 9, 2023, at 1:29 PM, Kees Cook <keescook@chromium.org> wrote:
> 
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
> 
> |-------------------------------------------------------------------!
> 
> On Sat, Oct 07, 2023 at 02:05:56PM -0700, Eric Biggers wrote:
>> Hi Nick,
>> 
>> On Wed, Aug 30, 2023 at 12:49:53AM -0700, syzbot wrote:
>>> UBSAN: array-index-out-of-bounds in lib/zstd/common/fse_decompress.c:345:30
>>> index 33 is out of range for type 'FSE_DTable[1]' (aka 'unsigned int[1]')
>> 
>> Zstandard needs to be converted to use C99 flex-arrays instead of length-1
>> arrays.  https://github.com/facebook/zstd/pull/3785 would fix this in upstream
>> Zstandard, though it doesn't work well with the fact that upstream Zstandard
>> supports C90.  Not sure how you want to handle this.
> 
> For the kernel, we just need:
> 
> diff --git a/lib/zstd/common/fse_decompress.c b/lib/zstd/common/fse_decompress.c
> index a0d06095be83..b11e87fff261 100644
> --- a/lib/zstd/common/fse_decompress.c
> +++ b/lib/zstd/common/fse_decompress.c
> @@ -312,7 +312,7 @@ size_t FSE_decompress_wksp(void* dst, size_t dstCapacity, const void* cSrc, size
> 
> typedef struct {
>     short ncount[FSE_MAX_SYMBOL_VALUE + 1];
> -    FSE_DTable dtable[1]; /* Dynamically sized */
> +    FSE_DTable dtable[]; /* Dynamically sized */
> } FSE_DecompressWksp;

Thanks Eric and Kees for the report and the fix! I am working on putting this
patch up now, just need to test the fix myself to ensure I can reproduce the
issue and the fix.

In your opinion does this worth trying to get this patch into v6.6, or should it
wait for v6.7?

Best,
Nick Terrell

> And if upstream wants to stay C89 compat, perhaps:
> 
> #if __STDC_VERSION__ >= 199901L
> # define __FLEX_ARRAY_DIM /*C99*/
> #else
> # define __FLEX_ARRAY_DIM 0
> #endif
> 
> and then use __FLEX_ARRAY_DIM as needed (and keep the other "-1" changes
> in the github commit):
> 
> typedef struct {
>     short ncount[FSE_MAX_SYMBOL_VALUE + 1];
> -    FSE_DTable dtable[1]; /* Dynamically sized */
> +    FSE_DTable dtable[__FLEX_ARRAY_DIM]; /* Dynamically sized */
> } FSE_DecompressWksp;
> 
> 
> -- 
> Kees Cook


