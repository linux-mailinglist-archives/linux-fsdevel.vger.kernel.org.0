Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428274238C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 09:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhJFH0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 03:26:11 -0400
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:29152
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230013AbhJFH0K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:26:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM6f+dhQDD2n4OICPqIqo74f/Kfc1waNh7AeX1RLiUWzH9SDFHL12wd8G86VN6cpkBEf8Aqt2vQUsZSf64wlSJauZDq7WCZBcIYjBU4GRcdCFiqMSdPUdorjF9LYdTROKLWDXpCt86ui29jcu+6unZDAJkzqOoscRbbzHnYbgAVQixTMrOrCO9hfrCW0YWB/0q6W+0+sPYhXPRMBBGM3DcoFOvZ8m7qhl/wLTcxu17jb0eReVZx4oJ14YGX/gjdsflQ1uIfJVF4e3eDFTHwTrJhx9Tpm1q7WmT2nhgY6gHWdEr9L9UrKMJ7YtoSiCSa4OpxCQ9yIypW8uzQOamZy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YswrTmtIcYnUUD2tHUuYwK4odmT+AstaOnrrStY4c5E=;
 b=dvaLu/kJOzTiBb715e2MP2JxHCLjC1F4RPXDasQb5I16pCI7V2gO48lwMnU8RUeIhUVhIskem5tBVSE5rKDtxWQghPMPgAXM4YfwwASP9GSdd2XS9h2c6obn/jkNDa8wEEfpuQ6lUZuz28os2WktQMZ4QM6GIkpQWthxXFm7EodAhS4093zQkjvgY1xm2aquWYPfySj0OQwrMzwfX68wRsRn0p60apF3hiyqkuM8oWytDktTTli2mqwr3JzHDSadc+gJq066JHISiQZ1lenrecrwxF+PY3wL2LWXPuWd563Gn7m++9kZ8U5SAkOc6xTP/XXklFmnxdCxV8zvU+aEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YswrTmtIcYnUUD2tHUuYwK4odmT+AstaOnrrStY4c5E=;
 b=iNRnhftfBL4ktVZyECqaZlh9RL1Ol0oU/EYTAdf6ymn0t52mcxtpx5G91z3mYBIMg4/goZFYVr+TwrHR5NNz7w4COiDAxdy1fX8wF77OEDWfzTRcbI/mFfg5fBHFcruxcBbTMltdjddSTKu21sSBWIAPXbxBZA1T1a0Ql9KePSc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1677.namprd12.prod.outlook.com
 (2603:10b6:301:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 07:24:14 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4587.018; Wed, 6 Oct 2021
 07:24:14 +0000
Subject: Re: mmotm 2021-10-05-19-53 uploaded
 (drivers/gpu/drm/msm/hdmi/hdmi_phy.o)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
References: <20211006025350.a5PczFZP4%akpm@linux-foundation.org>
 <58fbf2ff-b367-2137-aa77-fcde6c46bbb7@infradead.org>
 <20211006182052.6ecc17cf@canb.auug.org.au>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f877a1c9-1898-23f3-bba3-3442dc1f3979@amd.com>
Date:   Wed, 6 Oct 2021 09:24:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211006182052.6ecc17cf@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0044.eurprd03.prod.outlook.com (2603:10a6:208::21)
 To MWHPR1201MB0192.namprd12.prod.outlook.com (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by AM0PR03CA0044.eurprd03.prod.outlook.com (2603:10a6:208::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 6 Oct 2021 07:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65264450-7480-4848-f874-08d9889a4c62
X-MS-TrafficTypeDiagnostic: MWHPR12MB1677:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16770F6C1F4F85F487D4F91683B09@MWHPR12MB1677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuvLKIA8sY0iaighXmkfSc8TsnofKm+7KxKn3xagoP4Ue4Oqsz3hKqcxv+eO9/pOi5Rxdgzg4SzXJ2LK0BUazAsrqyrD6Au+syDl9wACO5LFsExlJViv4azPbbvwSWJyIS7SfDjT4ob9K08BKENM04XS3UHut0zRkP9vAeScbAQrHLcwafxWFoaJQCZa7lGqNY89hf2bhPEmkNLRgUmChSzAs04zkkx/9hbkuZeGDneN9K8ThDxO5M35cSjvPXJyovhI2oypq37IvokuOqEj4Lf693NSn9BVdLwtuImj12wzbsHuUYT9LH0QhiCvS0PoqSe9+HV1D57MbTDes+ydGxL5nNfPetuDKMhSEwxULxsHtKsgmFtlvGNORQqq+8EX+/CPwmiIsYxpcqly58ReCHtX3YWOxZNjokkurAps6tGYH2sIYumjljmSvoGhmgp00IJbmIBvs2Q3qAVy45gPcMWElQeRv0A0WgIDjRxhvjvSwZ58kO7t5ughFtv03m9lIhGiW3vDGrl6ybq91eL2K85Jlbz6CzSxYprtfgeYMpjQA/FU50wdC+T5LlvIsI8xkGztFGUkhWVRx6efOgZvvc+x566GNHtPCzCfTiAYfRpbvkvl7yQp7GjoF35PN9UD+myHX6TI6kGSFTbgd3ASaetPIgo1nv4MexfHXhAr9WWV8lFOb6hF2EmLDbMjtiaMLAxnmVk2nP/zfn+08ruSMqNBABY4ILzPiZ339hrjdOqWdzY2gX3kQL79gbwJbw7q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(16576012)(316002)(2906002)(36756003)(6666004)(26005)(66556008)(66476007)(8676002)(6486002)(38100700002)(31696002)(66946007)(31686004)(8936002)(4326008)(186003)(110136005)(86362001)(54906003)(5660300002)(7416002)(83380400001)(956004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?nLkJfcaszjJ54ADjkmichuIVfmFacWVy/Islp3z8U6LOlD7yaRkIYcfy?=
 =?Windows-1252?Q?WQbAgGv5j3YxxsxDTVLLR7V3Oyb6VZMKWV0h0Nsxf/ORkHIAopFL4pPX?=
 =?Windows-1252?Q?mGvnQpCoJH+M4/gfP7tf6bakfSICGAp7sNyPaBq1RZYlKRY0kesOcyjZ?=
 =?Windows-1252?Q?u6lBnyt97Xk82UUxgCOmqlfFmen1ntkESEzBJCBD6PWpAWmiE818YfCY?=
 =?Windows-1252?Q?E62XPxBtNINaSAmAWtem4rEwHIm5PjGKRAxER3cfMcVxOFtPWEkuVKB1?=
 =?Windows-1252?Q?NPsaBDwgXNJ91wF9nO3VdNbcYj8ejkon/yk04YHBp+EpqDrD0wVVP350?=
 =?Windows-1252?Q?C8vamrOBwReDBsC0mwCmJ2AbN2YcVUNnkllMIe4ZmhMptzLAZhRYCaxJ?=
 =?Windows-1252?Q?5DFF1NN3V7GjTojAmXETH69HrX6riJ2vRslyeq4pc7IHc9tRt+x3P+FH?=
 =?Windows-1252?Q?1Zyj4kSf5xAxoNkYfRiPQQDJ/Y4F4TKvgfycW/J/8UOJhbr5NBSFRoSL?=
 =?Windows-1252?Q?JAK3SSC8v1KJNWzFNJltx3cN048rbamhJwkAMR5ie+3xF0pnKQ73qR0g?=
 =?Windows-1252?Q?h1hp9IXLn0ImjccUulXJ7HmP1i/dqzuU/dl+hPyaDRcwtQRATB66lQJS?=
 =?Windows-1252?Q?GRkp99H8Emf0py/xs+yOojoO68oXlm0LMEegud5U+mNQAFmY80TP5Dp9?=
 =?Windows-1252?Q?TzeJd2FI5mH8WWWm68K1v0Ww0K9RVaKWqfnYRB4SGTPzRj91kW0lVttu?=
 =?Windows-1252?Q?+rUNZwxN3tnygdufm4UpFTUJKUFWI5ovKsOF84dizraQ4f37616qabWX?=
 =?Windows-1252?Q?QpLu9TnS5wnuX1ZT39O1IbrH13y6bbBXOzTBwoGFw+46u04NBTIvo6V2?=
 =?Windows-1252?Q?Dcas/OKH9z+dBC6sFD2klnRdbYALpQYD/dXqOquHhtW3JlxnbTVq6iIK?=
 =?Windows-1252?Q?N/uEhg6t99NTNxwPi7BAtHKJFLEzPmOvhg6pb6isiqRnB294wWeagAMq?=
 =?Windows-1252?Q?vmpT82Hj527YEgEs3qwQTRLmKcRRKWM7d/4bmUse/0HhQ8dZl0Sr0gNZ?=
 =?Windows-1252?Q?Sv7mQF48N7Pp83iXKjjrXQLv4p2u0WPmfS+69jBCJbUk4dIGI/3t4jg9?=
 =?Windows-1252?Q?1q8ylKK1otmLcbd4LtecyoeALbjOCM6+z4GPBXRPfvtDbqYE+7RCKrWn?=
 =?Windows-1252?Q?wak2yU1AmOvejIv09qdUBueBnO0y76gAoJt7s6UHIsDZ9m8KDUhWPRAl?=
 =?Windows-1252?Q?eltHgWmK7H612jshUqHiaD4QbzLzmGnme5jYufa/aa9EY1jzTKd0xy/P?=
 =?Windows-1252?Q?k4KFn0+bcVP/Ctcaek4/7hWL4JKoNgkowPWHjktktnw4T7H4R55MSxlX?=
 =?Windows-1252?Q?rybk/YvWvI18uHtlCo32tYfE+ApSiuae0MzzXtoS3Jt2h6QRFDQYC94h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65264450-7480-4848-f874-08d9889a4c62
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 07:24:14.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1z7Y/IFBBfuofH0e8QYfkIgHIbBxQMz9Dh5vCWB6kWbBrJ9dwSV8h3ASd7sm0gqb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1677
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 06.10.21 um 09:20 schrieb Stephen Rothwell:
> Hi Randy,
>
> On Tue, 5 Oct 2021 22:48:03 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>> on i386:
>>
>> ld: drivers/gpu/drm/msm/hdmi/hdmi_phy.o:(.rodata+0x3f0): undefined reference to `msm_hdmi_phy_8996_cfg'
>>
>>
>> Full randconfig fle is attached.
> This would be because CONFIG_DRM_MSM is set but CONFIG_COMMON_CLOCK is
> not and has been exposed by commit
>
>    b3ed524f84f5 ("drm/msm: allow compile_test on !ARM")
>
> from the drm-misc tree.

Good point, how about this change:

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 5879f67bc88c..d9879b011fb0 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -5,7 +5,7 @@ config DRM_MSM
         depends on DRM
         depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
         depends on IOMMU_SUPPORT
-       depends on (OF && COMMON_CLK) || COMPILE_TEST
+       depends on (OF || COMPILE_TEST) && COMMON_CLK
         depends on QCOM_OCMEM || QCOM_OCMEM=n
         depends on QCOM_LLCC || QCOM_LLCC=n
         depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n

Regards,
Christian.
