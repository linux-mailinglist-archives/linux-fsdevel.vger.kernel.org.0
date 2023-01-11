Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22D3665B46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjAKMXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 07:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjAKMXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:23:18 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCF0E0FE
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 04:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673439790; x=1704975790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FgHdp+fIueO8Dx7k7oPbD7H/5nCIsJANLa5B9c+M1Dc=;
  b=hjLTmcxbyiJBvsqw/BU/AqFfegF9Txjt0P2qOrcTH6p10EU6v1VzEF+m
   A0SP+g9PxpWocOTZqFN4HM2AdYHkAtf2gzoqXy+fXXms0P3eLsGE5AOrY
   i9C2FeQCLYQzzJFpFEPUN4CfGM75UaTj02ETN4p53L6jCQihAlW7+9H+l
   VhIPijrSxNusw3uskxze/1Uzx9pkXc9LJV8kBZ5uFH1j8sbudqvCoW7rg
   R+qGzWNbA0wdX+kzbs1HVqA47ACvDhupprfc1118UkmZoUs4Ru2/j0ETl
   ILUNXZNPPesqiTIFcY74zJz9kwijUlO0jr3w1YTVcaEYRLH5eliyblNPD
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324828528"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2023 20:23:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAHKwOWQOExjGXobY6/wRNt87C+mcxc75jVcVuNzJdgrWLcbdyF9j8aLDbjJ2DnRBcbgUbGCpuv7N3STcgDn1BpkcwfnnfyEYZ9p7EVjlwJuxPrZUKnzs1iHuQ+HPsR4/SyGLCWSiRC/tBtcuNc7Itzrjz3F8UbKVJp+5g94lBrQpRmrhPEAJsw6Dt+5fMHHg5PMuUijcvQbKFbY30WssPMKEpMV+RN/9b2ZJevSIcIWHEBC4yWofiPMKzzQMWFO32EaBEhE3yBlnkjjhxJBWN8Kd8hyIWvRDgzJbnXK+2IRa4ShH6T4Jo0KoudJP+qHbFOiMb7hIahHhf4xoOj+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgHdp+fIueO8Dx7k7oPbD7H/5nCIsJANLa5B9c+M1Dc=;
 b=STo0P0DJAcymL9cPEeKQ0wWSecI9Zcu6Cnas5G77LrmbSiUKnR3Y6JC5wof8H4Jtp5Spt6jtLlpvy+c05MLvkIylQ8Zb5pcNjy7QS8Dl2bLVI/cs8jMPE1NTlIAH4omFCl8QYs886poqNHI3vyxjeR/IbzrOWwLMe1eFWtNcI6MlRZYl4jdogpoLIkN5l2RMjuBrsBE9sTIA8PX5dl6J3BINJ+D8vJygyOSO8jXT1y6F6OZP33XI8Jr/1guoZ1+7mXs3YudSAYNsuOgw8JoKUicqppOmGSy1PAk30x05zSN8vi+2zKCT/Fj2LSAUN5EZiZ0ZM9/qDWUjE7KaBxE8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgHdp+fIueO8Dx7k7oPbD7H/5nCIsJANLa5B9c+M1Dc=;
 b=zYEH0naBLjblobHDXukq/HZZdWOv0HS3UtSEE59tnMqYBgtiUMSVOe6d3fvPsF4su7vRfR7VovMVeWZJwYkZiKhJ7pUQClYEx23PXi3MFl1nc5z5E8khzYdllCmVfINf7H6ks2szDdd0aK63BVmrg6m5LeRL9ZpAzXZxVyn/Vk8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7574.namprd04.prod.outlook.com (2603:10b6:510:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 12:23:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 12:23:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
Subject: Re: [PATCH 1/7] zonefs: Detect append writes at invalid locations
Thread-Topic: [PATCH 1/7] zonefs: Detect append writes at invalid locations
Thread-Index: AQHZJPSnnkNpygGX402rZ3RMdzmU+66ZJP4A
Date:   Wed, 11 Jan 2023 12:23:04 +0000
Message-ID: <cca3c2b2-38fd-ff76-8b58-ad70a2eaf589@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230110130830.246019-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7574:EE_
x-ms-office365-filtering-correlation-id: 10a9401e-24d9-4ac2-8f88-08daf3ce96cd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdHwtYX3eBlWEbdLgPBz2rava0VDlxk7kT+i36GSUHkuoeFEiIra1XITF9o+neM0jseNepqYdBMZk8a5dnS2UAt4mSBIsL9moD+ZfqyuBD7ec8NBgZPtly6JkzIMZ1aaf3gCAouUeg8sUhf50bl+S/K/3oAsHOojp7XzCekB/o8CnzlrtPPmKHHQrc/jOa9/fOzOutTTTJJw4tNez2f3CMqy9EnbLaNsKIJV3n66vOQnOzdGzeGwD71yVWdfwAhFADj9SnukEDoDotPbDVbzDkZmI6h/OAdqXHcma2f7QVgm5ENyTn1JF+TAfL2GcJA2o7t6ax4KDsYr5u+ujUUo5kZ1D7obDJwIWc8zylTaCKHQs1rphFkMCYjzOibBPZFcgJNRCx1viEPWKAFFldlS3OgeUrVw3bfKAOX/STe9VpaNeWVS0pacqbydLawMPfD1xgQ++BVcw6S00A4wDtMwx9c7CKN84V2FT6dbioOlb7SV70MIAvFLJNHtgAKeO9yuTVxiiPO+5ljLmOoA6ZLGdg4Isk4yfkxAM000Jc+MQzj5ykjaHIKxF5XefBOwf3uNawVl2MBWYMlYgqlMhIUGa8ZxlEc6VZAUMls4DnfWisKJ10EQDDNq8hrVudYSENv4KJi5tny4e4N0UJaDIjQweyecDNjJUvqpVf0XbFQJ11L0GSZvAXHadubr6ao6th9cGByCqC8AYJ8VhW8aA4tESv4n7cP4nkZYurM5AwTXXRu383ajicWl2SnHeJGaPu/2jbPUzdAxa+jeaFbqdu+DZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199015)(76116006)(8676002)(64756008)(66946007)(66476007)(66556008)(316002)(4326008)(91956017)(110136005)(38070700005)(2906002)(5660300002)(66446008)(8936002)(71200400001)(41300700001)(36756003)(53546011)(31696002)(6486002)(478600001)(82960400001)(6506007)(122000001)(38100700002)(2616005)(6512007)(86362001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlpYRUVUdGtlam83M1RtMVNXQ3prcWVuTTRUOHBtUVZrT2RndXNmaGdWeGZE?=
 =?utf-8?B?RFN1ZVd3UlB1UHpXZUdvQWx0a3gra0EzQlVSYndHZXdKMlhJektmSUhaTnBF?=
 =?utf-8?B?d0R5RXYvbG5KQmRWc3U3aW1sdy9rRGdMQlQ1YW9wV1pGZURzT053aGVUMkZN?=
 =?utf-8?B?QWsrQ082VnNDamRScitNVHF2dFk0ZzI1bVFNLzRIWnpaYnRJZU5VaUk4VjFH?=
 =?utf-8?B?VWF3Z3pPYmthTVhpUmFjT0V3aTBCbWYyZlJyYmZHSU55Z0N3TU5EMzhFYW9P?=
 =?utf-8?B?SENKVEV1dUhMTm9POU9ZOHRNL0M2SXJ1YjNFTzV6c0tZeEN5K0RQZGJRUXVa?=
 =?utf-8?B?ZDdIZWNUVXBpZWJJU0RHTjZaUi8zQzJWbVp4MmpZdVl5K1p0MkpvbWdtaWd4?=
 =?utf-8?B?U3VibS84dnFsYytPN1VKQXJjRXovdEZ6NTc0QzYxVDNtRXdzYlc1WktiejB5?=
 =?utf-8?B?SkVTMjR4L0dKUkRIQmp0akVuTDlXL2dmRnhVblJpbi9oM1QwV2VSd2hZU1d4?=
 =?utf-8?B?MXY0WFJuZURmNXNsR1FZK0dwYk1DazdtdHV3TXhJaHpab1VmcnFNQ1MyeGcy?=
 =?utf-8?B?b2YrdjRuUUhoVmptVDlOeDI0K1BqN3VaSzhtcjkrK2NBcUxZbGJrY2FrUnRD?=
 =?utf-8?B?VEFGSVgxcjQ0aWdzc0VqRHh0TWxCams4NFV3enVRNnFXYmRiVS9NSFpWQVNi?=
 =?utf-8?B?RGNQM1lxMmJCOFZWREpydTlqVFRKUjY2anJuaHlWSWtGY3lYY2ZXODdSVkJq?=
 =?utf-8?B?OXNEWUVucEpMTWpHOVlZYVZ0ZFlaendHQVZHZ2ZuVTNWWWRVcEc5anYxT01r?=
 =?utf-8?B?c2ZQSm9oV2Q4S3hTeGtYNExxUE45djBNeDY3cVE5NG5BY3NRQjRhKzAvdEdI?=
 =?utf-8?B?aVRkNGxTeFN2Yi91dWJlTWl0d3R1YU5NcWRsTzYyS1EwTVQ3T0djdzVKYVh3?=
 =?utf-8?B?MGgwNFZJelZCcFJrNURGaHh6bndGLzBzRVIwZjVPQXBrVWNmVjZWKzdpbU1z?=
 =?utf-8?B?amJRL3pnL3Z3N1JzOVA0Uzd0WUNVczBDZHpEZFpJMlcvR0d5SnI3dTVSU1Ry?=
 =?utf-8?B?NUF3ZkkwY1pERE0vRHd1NnZIZVpLMkswL3ZiU3FTaHg3MzJLRDdiZ3FReDVK?=
 =?utf-8?B?ZEhuMlo3UlZ6b3RCeWUzaysxSFJtMktpbFRkVjg0dElPQkxESjVTN2hQTEVI?=
 =?utf-8?B?dVRIV2dFOWYxdW5zZ3VENER6ZDdQRjFqNnZXNVcwSldIdVU0b2pXbkdSNStt?=
 =?utf-8?B?dW90a0VqOTlhVDlxZDF2NTBSY1RYNTlUeXdkcFNOQnk2SFJXM2k1QzludkYv?=
 =?utf-8?B?UmdMVGNpU0dseVB0dnY2OEpaUjJjcTdTd29GVzBIWERtZ2t1NjdJamltNmNl?=
 =?utf-8?B?RjFGMDQ5SUVjOHN4blJBZW1ZQUlrMXJyQlRTazhZRll2dW02aWl5Y1JOaE5M?=
 =?utf-8?B?eXdLWlN2RzJVYVpEZzVHZ3FibzF1bWpKcW9IbW1WZjU1em5jOCtkUnJUeDlZ?=
 =?utf-8?B?UUozeDU1U1UxNU11dmphU2YrU2F5bWFTRk5VdmxvUlZvc0hFdnhVc2JVb0hh?=
 =?utf-8?B?czBLOEQ4cmJqUENxSmJ3RVZxdHpySzhSdkFvUDZTblhsZDZhSjliUHRFRWtR?=
 =?utf-8?B?c05SeGtNUXd2SzVBWDZCSlhFTzFQcS9GQ0dZNTl1N2NDVU9PQmZMZnBrNE1S?=
 =?utf-8?B?TUZlcThPVUplZDFzdHMzZitrNzEwUlUySjA3WGNZN2tzaGpvWmNPNGgvNTkz?=
 =?utf-8?B?S21uSi9sdVRMbWc2V1dqS3FBSTBlY2hja1UxUWV2dkZRUTZ2emZYSTEyYXpU?=
 =?utf-8?B?ckc2THpWRDZiOTVkVDNmQ3podlQxRFRqbFd2K1BuVjFhT1dMQS9jY0ZmV2xm?=
 =?utf-8?B?N0JPaW9tVzFabTV1ejgyS3orMUIremxSSUVMNkhUYVpjdFFyVlFUS0lHRFUw?=
 =?utf-8?B?WFU1UlFQbnIycS9sUU1QaFRzdWJMZmhPcWJJd1N6NVRoZVN6dXIwR054ODRr?=
 =?utf-8?B?eTYwMzdCcjNER3FORnlsNkcvL1lwd04zSk1KUXFDeU1MVC80bkRWKzlCQ1NM?=
 =?utf-8?B?MjJTLzQvd0VLYlloMTBqYzYraVBwcDlEd0cyendPZTdQTlZXZkpWSitZN0tO?=
 =?utf-8?B?eWxIYlBXWmdRc2lVMzcwT2psTUhuV0dvTTZab2xBYkF3aXZ2bjhUdXovNDlE?=
 =?utf-8?B?a0FFMGpaczBYS2diY05FVERhYnYxZ2FLMXg4azg5NlNNSGpBcHMxdHg0S1pv?=
 =?utf-8?Q?+TsRhTvS20cv+sPImQ963wvTVU26bPPwPgHMwTklyc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CFEE44087C93A4C97A4EE4E7DF3413D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dGIc9qRlk4X6o3pSRJ47Lz5J/y1hH3uhuPgAAiu2XGZ63uQEsF9AmcxJJ3Drcdb0nXW6bDzRPk/Ek9eEVFwyvfVTwKF7RjHgnE86N9O5INxZef9FbMDENBu44vyt3NKNaEShyId5kYEQNwmlBUf5t1FyKwCYpG41IuYQsw3++ANec3tALFl5WTRrO5xNNeTaV8/jDAPgfDwCrfkhDa7mHkzP8tFchEp/iLVGt3ysWe93ql5cHlw/XFFqTFZsT+04wjZ4S0Rg8L6lV6H/tRXsGf8NIkWxCJORpiEpi5vZJBAI9rz7PU28CzVeHD+YbMj5x1HCHeflbAi8EgmpHg7jtFofwIDldLukdxQvl2D6pV/kbGLTIAWmCW7TWcLLV6DYFbkl4u1N7frRL6u4qXTfLE4Tuq0DTm5nPI49cAdZUf7r9dTCdyqC7Mlo6iZrpo+bZ64s5ozO6+9V26EHfeorQdI19sBUidm+fl8kzBvQ612h8gH1b7lcIakyY52HF2kBS9wP9YZHhau2jWJgGJAR1PQVWT+PmqUYPed905XihaC4MwqBrJZYiUelIq5KoEcUgjjWukBDpD/ewUzxX8vEPdKEpu38Br4Z1DevX+oNdaBgG7hVQ8Qo++uQ7K1kfaxCxrTN+SNFmXVRgahwry6muEK8vuHw1SB0IvjM7mVn3CrBYO6bTm+lLeHhCIRm9mmSy+v9tr25dukUhVxb482A+9ShJkyAIesx3F/iIsJRC2NAYoW7t6MehB2GSyP25d1aSv47kx7XwIFAWbdVf4nsQUXzmISyW+k36WvHUWimmiw=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a9401e-24d9-4ac2-8f88-08daf3ce96cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 12:23:04.4900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoeVJrnpapOZmmdLQGLp0yirVLv/YlcV0hp/exHNBn6q7GFJ+P/y1HtROkToPMNWB3V52wN5Yz3Q0U5Zk6bbQiS01O2d1vnyj0Py+A21wE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7574
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAuMDEuMjMgMTQ6MDgsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBVc2luZyBSRVFfT1Bf
Wk9ORV9BUFBFTkQgb3BlcmF0aW9ucyBmb3Igc3luY2hyb25vdXMgd3JpdGVzIHRvIHNlcXVlbnRp
YWwNCj4gZmlsZXMgc3VjY2VlZHMgcmVnYXJkbGVzcyBvZiB0aGUgem9uZSB3cml0ZSBwb2ludGVy
IHBvc2l0aW9uLCBhcyBsb25nIGFzDQo+IHRoZSB0YXJnZXQgem9uZSBpcyBub3QgZnVsbC4gVGhp
cyBtZWFucyB0aGF0IGlmIGFuIGV4dGVybmFsIChidWdneSkNCj4gYXBwbGljYXRpb24gd3JpdGVz
IHRvIHRoZSB6b25lIG9mIGEgc2VxdWVudGlhbCBmaWxlIHVuZGVybmVhdGggdGhlIGZpbGUNCj4g
c3lzdGVtLCBzdWJzZXF1ZW50IGZpbGUgd3JpdGUoKSBvcGVyYXRpb24gd2lsbCBzdWNjZWVkIGJ1
dCB0aGUgZmlsZSBzaXplDQo+IHdpbGwgbm90IGJlIGNvcnJlY3QgYW5kIHRoZSBmaWxlIHdpbGwg
Y29udGFpbiBpbnZhbGlkIGRhdGEgd3JpdHRlbiBieQ0KPiBhbm90aGVyIGFwcGxpY2F0aW9uLg0K
PiANCj4gTW9kaWZ5IHpvbmVmc19maWxlX2Rpb19hcHBlbmQoKSB0byBjaGVjayB0aGUgd3JpdHRl
biBzZWN0b3Igb2YgYW4gYXBwZW5kDQo+IHdyaXRlIChyZXR1cm5lZCBpbiBiaW8tPmJpX2l0ZXIu
Ymlfc2VjdG9yKSBhbmQgcmV0dXJuIC1FSU8gaWYgdGhlcmUgaXMgYQ0KPiBtaXNtYXRjaCB3aXRo
IHRoZSBmaWxlIHpvbmUgd3Agb2Zmc2V0IGZpZWxkLiBUaGlzIGNoYW5nZSB0cmlnZ2VycyBhIGNh
bGwNCj4gdG8gem9uZWZzX2lvX2Vycm9yKCkgYW5kIGEgem9uZSBjaGVjay4gTW9kaWZ5IHpvbmVm
c19pb19lcnJvcl9jYigpIHRvDQo+IG5vdCBleHBvc2UgdGhlIHVuZXhwZWN0ZWQgZGF0YSBhZnRl
ciB0aGUgY3VycmVudCBpbm9kZSBzaXplIHdoZW4gdGhlDQo+IGVycm9ycz1yZW1vdW50LXJvIG1v
ZGUgaXMgdXNlZC4gT3RoZXIgZXJyb3IgbW9kZXMgYXJlIGNvcnJlY3RseSBoYW5kbGVkDQo+IGFs
cmVhZHkuDQoNClRoaXMgb25seSBoYXBwZW5zIG9uIFpOUyBhbmQgbnVsbF9ibGssIGRvZXNuJ3Qg
aXQ/IE9uIFNDU0kgdGhlIFpvbmUgQXBwZW5kDQplbXVsYXRpb24gc2hvdWxkIGNhdGNoIHRoaXMg
ZXJyb3IgYmVmb3JlLg0KDQo=
