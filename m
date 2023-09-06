Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B153794145
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 18:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbjIFQPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 12:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjIFQPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:15:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01323198B;
        Wed,  6 Sep 2023 09:15:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386FTlj0018843;
        Wed, 6 Sep 2023 16:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7xsoqjt3mVjux4Ce+nE7N5r8eizcrUiL/Q29xh/j6vw=;
 b=BKSu6470PeW4NOJuabpjIeGJzuJ+wArZP2vctrcWSYOeah6KpOjFFnF3VZcU4pTseJHQ
 HvP5N37TiRS5gDvdgPbz8vAcSUKOXBtDhPT1X1/QNA/fSnI22mWSNGPHlusXYhNIAESs
 E/qO8khi5SefInQ1LA21XfqSwfMJe8KDPuN+cnsSrk3zwhRIqaiETeMchMRIGMmGuoLg
 ZpMmAvpJ9ua/Si2b5JiXeKmq3hrxu11/6EgkpSbj8jUJ81LsAwcExtHRQ3QfkuvWJ8sZ
 88TKI2LwmUixNhtxOnwjdo43UEtRlVVdzC/wzVKn6ioOYY5PPIcn9jQbkT2lUBG/sYbc sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxv43r5fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 16:14:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386Frg3p037085;
        Wed, 6 Sep 2023 16:14:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugcqwf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 16:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/c+pfJWsq61cyZvMmHTMn+rYoGvARJYOEaXUFzWsmL+xQnRTnJ68opUMSOC00tVkyAMSot1RblMtqrfOFecGMMcMcP//7wOkuXtSns43hbNIAEu+mFDUckF+Ck/i2+hs2iNwh2287CQ4m+3AcLy1w5RF7VjljuOV13Cp1HWpj2UBPcTcioG8XMf6XwhWf7/EZYjtDAKvEVmS+2xIc357sQBeAcTa4WnDIaqLLHx/LYvjYTGTyYLQjpxxfPdABKkIqPnhOBya46gi3d5ft8v2qgR3wF2T4h43Trtc/PR2EbxzreRIYDyg9Fs7lBN1kYeYlzzyXWk1KWd8O8oMjvQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xsoqjt3mVjux4Ce+nE7N5r8eizcrUiL/Q29xh/j6vw=;
 b=Ntkdi5Wa6hvpbRogHd6Q5s2dfgim+nF4Sscrw+AxuLWOhrkamZuUtQ5w9e6Nw+XKpI3a7k2PHCOWyQ+PyvYpqQWKlbfEqaRK2uy1lUE8A2MDDAH/VhlmtskuhxIsjxJBY9KfpNheLrZ0bJRcfa4Omu4WdcMgFpc+vBTLNt+eXo8i9vcTVG7ykSYUbG3VOo8mhgjkI+AXNrJsLxjZZdLs1jeoq25+bQ5cgMMThH8iQFzKAQyx9FitRN8eZ8i4utQyNcp3dlyC0xvm/RhAjwJ2cUAGWAqTSI7wd1rBTLGc8DfXhBN0Ml2kUw2gShMq6ROl73RLl/tajAgEZda+cHh4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xsoqjt3mVjux4Ce+nE7N5r8eizcrUiL/Q29xh/j6vw=;
 b=PjU1wgs/lF+44P/l0Os13Ay1hAKZP/GHVOS1x0kZZQB7PfQ9VteQ5SYZeLtITOiXVeblfUeBtDg/s3CV0TSnHxi3AG+CqQUw2HHfNlof5x5iTX3p/gMtFRwqquXGUI5E7fDLi6toovKmniDVVHNDmo0PKLSOkuduhC4XEGmD+zo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4305.namprd10.prod.outlook.com (2603:10b6:a03:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Wed, 6 Sep
 2023 16:14:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:14:31 +0000
Message-ID: <f700b53e-328d-cc69-937f-e4b8bfd8c37d@oracle.com>
Date:   Thu, 7 Sep 2023 00:14:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230831001544.3379273-3-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d02cd29-232a-496e-1dce-08dbaef459f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPCN0F/2U8ZHycPdhdbsR4sC35TuZ7qbrBWHqg4q+ECSjIEh7X8IaVoJmtCeDNO4/TKNhZq0HYpKOEcATYnMWh53s5olb4rC/FsJi9K2BYofLDyj82I+g6QWHlXweVX3/mJrvrUmvJ/xQP1VJGkZgibOTyQNB5OE/JHQX7SFzT/+vHekQ70JtyN2AZYJh7vlcAKvNuZuxwF/TUH8CWox+qgUb8QvTCFXvAC5YjUyeW8s+21bdrGakEJ1l4GT8X4AW099SnhsZfBngj2OxZ1h7IrMB5JVQV7RQ694lU84LREQTxguDiZa16yuHqB536+SbMFam2aKfpbXRiZdbXPjjyAF7NsghufuWzjaDubWBR8wWhrIK4QMbnx+kkzcijvEHKtV8GURHr3E3xOhmwNTAgrVw+2ynJP8a5GVP8+xOza4faRT3Xpy9rAkDEPt1NZn1vKTgR3/c+t6d2kmgWqSgWAd4exPgCYNxypxR/p6cQaNJil8MnaMzjmovaMui092xM2hInD2Vn8CeThJN04CLFqyBmR0/45R3MYEIWIb0OjpF41lKTUNpQbaONqyYGp6GGfCkT/DaMhqd7xCmXEZLxEJXHPTwZdwxja6W7H7QvmrvVQvEi1c9kL7Hb+CdR7pEzTSiDYalIFL9kYlffK0FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(186009)(1800799009)(451199024)(2616005)(38100700002)(26005)(6486002)(6506007)(53546011)(6512007)(36756003)(83380400001)(31696002)(86362001)(44832011)(5660300002)(966005)(30864003)(7416002)(41300700001)(316002)(66556008)(66946007)(66476007)(8936002)(4326008)(8676002)(31686004)(6666004)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDl3RlV4T25iYUlsbDNiMnI1Wkw0N2U4bVI1SlNRcEpHN2orcng4dUx2YkJ0?=
 =?utf-8?B?VStCdUQ5MkMveDcvZXlCN3JmTGFtcFdRUVFTMGREVkNJSURLRUNGMUp6VW1J?=
 =?utf-8?B?YjRUeG9IV1Uwdmh5UWlpN0VmTitERnlzeTBQTVhYS0w0S1VBYnZ0ZWVOaUsw?=
 =?utf-8?B?cVd0K0pUVmk3SmFqVGI0MVpnb0xwMzVoc2lkMmhYbXZQMFRvdU92SHB2SHVo?=
 =?utf-8?B?aDdqMWgyUGNUc1BTWFJGRmQ2SHR1TU15c1JTQ0FoamVNeG9mUEpZbUVKMGVq?=
 =?utf-8?B?RmxZQ3Mxc2xFUkMzUURJTHNHTTJpTDdpem1VKzFlU1psK3JrelYvWmMvZlJq?=
 =?utf-8?B?dksyenp1anFaOHNuUGZNa0pOMXlTUlRSa3B1OVlNZll4b2w0ZGFuaEJNeHV3?=
 =?utf-8?B?WnNkTnpCRWdrUzFORzNGeFFlVmVOajZWemdFdklJZW9qb3hyR2RsQkt1bWxE?=
 =?utf-8?B?Y21MdVZjV3AvR2NUQm5hUWVVakJ0emJTT0J6ZExRdWZNU1ZoNTR4YnEyM2li?=
 =?utf-8?B?Mk4wQXBFT0F3NHVkZ0FrQ1VUS3FSb0d1UUg0MVlMNDByUkc5V25mbGRCcVVu?=
 =?utf-8?B?Yk1XeThURllwaFJ0U3BUMnA1TzVjZlQvOUdCUXZRU2JrTk1BWjVsWjZWK2pp?=
 =?utf-8?B?MVV6dEZ5T2x1cGR0TTFselZXQlRoaUs4S2NJTjE3eDNQelpvbzdDQzFZUVJ0?=
 =?utf-8?B?Smphd2RwZENBYVh2UHZDVEhZRk9zcU9ucGt0MUtKcmk3MjVDUkxEL2pLSFZz?=
 =?utf-8?B?a1JwMTZLVk9PUHZObGdnVE9ZN0lQaWVVYzEyZllhR2tRWTFpcnhPMndPR3Bx?=
 =?utf-8?B?SmlNelpzVkdqOHNxdjNqRGtORHRYaVdFQW1US2hiWnlPajRKSzZ6WTFOYTJC?=
 =?utf-8?B?Z0EyWnlBOXpDeHZWY1dOWGxGaWNCOVJHdWVUQVVEcVNPU3IwSjhUUDN3ZHVW?=
 =?utf-8?B?UlNmbXR2VE5HVi9OUS9PTWlHRnNjSWw4NVd1RHh4cmJZM1NRcVJoOUhSUVZj?=
 =?utf-8?B?VnpSd2VsUEVibGFjcDdqNWE5dnhFNDh1NlBNZ2ZLaXA2eFVxekNVSFlNd0ZT?=
 =?utf-8?B?U1NreGZYSmREdDg0bVB2azRYNkFxZS9uOHA3Vy8wajgreDlydDJoakMvV210?=
 =?utf-8?B?M0t4Y20vU3RmQStKbFZxSm5teFBJWjJrTzg1RTIxQTJESUo5aU9HUnJmdUor?=
 =?utf-8?B?Z1NYYWI5VUpCUVQ5c3haZFZrNzhudVBoR0R4UTFGaE9PakloQzhxWEdTY0R6?=
 =?utf-8?B?SG5JS3dOaytUTDBtSDlibnU3dHNLUnE2RDhEUmx6T3dDRFdpR2haU25XblVB?=
 =?utf-8?B?eHE4S1ZuQnNRbjlvbXVWSDVBVnRXeEp3U1pOTXhQY3VMemRFeThoa09ldUV6?=
 =?utf-8?B?UGJWNk8xZEwvUUVBTGM2NlNlOTVrVlBlQUJhNURTZWFoSGZMNGFEVjltVXNX?=
 =?utf-8?B?UUIxVHJDM2FJdDdFVG9FK1Rud0dzNU5kZ0lxQmJORkFOeWx4ck13OGZJSlFE?=
 =?utf-8?B?SllFMEJRcDRRd1g4SzI3eTZvekJXQWlKeXpVWXJkdnRnV2tOOHMwUE9nU0hm?=
 =?utf-8?B?Wm15UXRFd1MwU0h4cDhMalZVdVkzVDdDRHFkUFhod0NrKzZkb1NZOWJIUmQ0?=
 =?utf-8?B?K29yaHBJbk9xSEtSNzZieUVWK3d3enlyRVQ2Q0pjbUJuM2hHVEYzVitnbDNS?=
 =?utf-8?B?ZFB4cktJd0oraEE5L21kcEdkZkc5L28zb2QyRmxFQnRXcXV6MWJiZnBHbjRL?=
 =?utf-8?B?dUxIcVZpWExWbUdFOUdCdi9qK082OFZ2TlVPa1NDZmdmQWFJakZwK1RDSmg4?=
 =?utf-8?B?NjE0dmgyVS94RWJOdHBFVS8wZGs0UEM3akRYZGtLNTZIWnhxSjJscFAvQkNQ?=
 =?utf-8?B?WTVpcnRhSFlKMjlCaFNOc0Y0d2tJbkE3S3V3MDlPUHFXVC9zcDl4aU1VTEcy?=
 =?utf-8?B?eXBENjV0T1hySi9pSlQySWc3d3lJSmRqZGpGWGpsVVFmSG1RMDBsYS9aUXU3?=
 =?utf-8?B?VXBETWZjckFXZ2J1Sm5LVWlIcVBNTmdKZnVyNlhtdUlpbk1ZcVcyS25yMFRr?=
 =?utf-8?B?YWdaUFZKN3ZvRzBQYjVqUU1ha0pQT2NMWE42clB0K3lsWDBtQjA2ZHJpbXJw?=
 =?utf-8?B?SUdpUGVwTFZvKzlyTElRRzF2ZEsxYkt6MjFBME1NQzlmYjhGazV3aFhRKzk5?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UitwKzBYRlpNSFdURUk5WWxJY0p1S0JmeUF0ZlRhVGdPcGhSVGt1VFdTMm84?=
 =?utf-8?B?dkNoWlBrTy95ZWs0SlRJM1FzaDZVWUZ5VlBnSkhKNXBWQitQZDQxK2NuUFZF?=
 =?utf-8?B?NkdyZzI5cUFnbTRYTG96Mkh6NjAzaEZlVXpZVEhFeHVwa1pZWTIvcVlhRjJB?=
 =?utf-8?B?WTlYeTZPcW56VENCaklpaXllV0RvSzFLaFpYbmd2S0tsTncwemJIMXBYZlZz?=
 =?utf-8?B?SmZFOGEzZ29nUWQ4ZzltZk5CVDFRVDhvNCtvbGwwUkM4cTNOODI2TzU0cEJF?=
 =?utf-8?B?WmNWb2luRUlNZDd5V2ZOQ2pQNWtBZUw2ZzYwWHc1djBIdDZkcVdVT0pjVkIv?=
 =?utf-8?B?bmpiRk90RFlNWDI2K1ArYnVqcjhJVXJuM2tKUXJGYm9MMDU1emNzQndvN2VZ?=
 =?utf-8?B?cklQK1FmSEhnTmZVU0xqTzRNV0YzMk9NSVp5ajFSYkc5VjN5bkdlZnJrSzVz?=
 =?utf-8?B?MnNlWjhJd0dWSlpocjFBcVoyYXpzMGJhVERWeG5jQjhpLzJVMU1hUURPOFJI?=
 =?utf-8?B?QzJrN3piSkN5b01zcFVEN1BVRzI2Nm1vUG9kczR3emE1NjZodit2N3p2SURZ?=
 =?utf-8?B?Mi9Lc3VFRVF3c3BJZ0htVDhHV2M4WVUvSWlnVnpBQVVNNE8yYkNpaW9Rc3hR?=
 =?utf-8?B?NUZ5UU9GeXBZRnlvbHE5ZVNjSUJFeXJ6UkZnY1J0bURmeGJya0cyalJDQ3po?=
 =?utf-8?B?dFBjYnlzcThqTEorNEtBQ2d3c01YeHZSendrWmFRYkxvS2JnVzlBMWFBSUhE?=
 =?utf-8?B?NE5RamtFRndRc1FoOEh5TmFCQkJtQWRTQjNJUmdzU051WS94emJGWEgycWYw?=
 =?utf-8?B?MnBGV1JtMjA3TFc4RmN5S0N6ckV6VllQbzlhYnVTdFBFYzJRUFJ4VlZXaW0v?=
 =?utf-8?B?N202VENZVWxuN0E4bDRTTS9ybjBXb0FpTnVROVE5WTRPTjFnKzlHekxEa21F?=
 =?utf-8?B?Z0NYT1R0UGFsQ1FJQlBNN2RXbjJ1bWRYb1gxSWM2dXoyUlF2cGhvUGZ1b0ZX?=
 =?utf-8?B?VnRsVU9abHZuZWpzR28xQjRmOXNzdkxNUE5YYTFlRC8raWVjNUVHWS9SOFVz?=
 =?utf-8?B?V0diWVJ3blV5TTJYYUp3R1NNdUVoMUpBSDlCUm5xSW4wVGU0SXZtQVM3R1U4?=
 =?utf-8?B?RUVRZ204d05VSEwxZHhXeVkzekUxeGFVQzZJUE5TOVl1bGE2a3NaMTZyeGZv?=
 =?utf-8?B?RTlxd2dqRDlIcWw1VllyMVJveXl1dnhWaS9UUTBkeW9qUy9Za01iRnFQc2RI?=
 =?utf-8?B?bFhFSnlZYVlYcVB3enBweDFOY01NUmtnY1ZBZlFkUEIxbTNtMVV1ZUhHdW1K?=
 =?utf-8?B?ZlpoVWZtcFpjcmovU1B4YjlIMWUwZTFZU2ZLV1hvWklKNHNGVjFrZFB0cGk2?=
 =?utf-8?B?VkhqWVFqeXVScnQwZk95TktvL2pUcXFsbkNMM1Nncm1qd015eVhYNmkwRW16?=
 =?utf-8?Q?Br1iaZr2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d02cd29-232a-496e-1dce-08dbaef459f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:14:31.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QrLNFqmo1OkfjG2eUC4EyDV+Z57NH887k6ppEYuNExNoU+ADhhz5K/zqhP1N+mEGpkHuzykBI/EZkt/INPgmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060141
X-Proofpoint-GUID: 8k70Vc8rzNFY6aVOj614Tp3lV3baCFjP
X-Proofpoint-ORIG-GUID: 8k70Vc8rzNFY6aVOj614Tp3lV3baCFjP
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31/08/2023 08:12, Guilherme G. Piccoli wrote:
> Btrfs doesn't currently support to mount 2 different devices holding the
> same filesystem - the fsid is exposed as a unique identifier by the
> driver. This case is supported though in some other common filesystems,
> like ext4.
> 
> Supporting the same-fsid mounts has the advantage of allowing btrfs to
> be used in A/B partitioned devices, like mobile phones or the Steam Deck
> for example. Without this support, it's not safe for users to keep the
> same "image version" in both A and B partitions, a setup that is quite
> common for development, for example. Also, as a big bonus, it allows fs
> integrity check based on block devices for RO devices (whereas currently
> it is required that both have different fsid, breaking the block device
> hash comparison).
> 
> Such same-fsid mounting is hereby added through the usage of the
> filesystem feature "single-dev" - when such feature is used, btrfs
> generates a random fsid for the filesystem and leverages the long-term
> present metadata_uuid infrastructure to enable the usage of this
> secondary virtual fsid, effectively requiring few non-invasive changes
> to the code and no new potential corner cases.
> 
> In order to prevent more code complexity and corner cases, given
> the nature of this mechanism (single devices), the single-dev feature
> is not allowed when the metadata_uuid flag is already present on the
> fs, or if the device is on fsid-change state. Device removal/replace
> is also disabled for devices presenting the single-dev feature.
> 
> Suggested-by: John Schoenick <johns@valvesoftware.com>
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> V3:
> 
> - Improve messaging on device replace with SINGLE_DEV devices;
> it was a bad copy/paste for the removal case.
> 
> - Added single-dev feature to sysfs features array (caught through
> the fstests work!). Thanks Anand for confirming that it's necessary.
> 
> - s/pr_info/btrfs_info and shifted to checking flags inside
> functions instead of growing their argument list.
> (Thanks Josef!)
> 
> - Changed memcmp() comparison to use "!=" ;
> - Rebased against btrfs/for-next branch, adding the patch
> "btrfs: simplify alloc_fs_devices() remove arg2" [0] on top.
> (Thanks Anand!)
> 
> [0] https://lore.kernel.org/linux-btrfs/20230823145213.jfJYluPxXiX8zox086A3c8NeaQvvfYnJ43ZCpnE_KU0@z/
> 


> Anand: the distinction of fsid/metadata_uuid is indeed required on
> btrfs_validate_super() - since we don't write the virtual/rand fsid to
> the disk, and such function operates on the superblock that is read
> from the disk, it fails for the single_dev case unless we condition check
> there - thanks for noticing that though, was interesting to experiment
> and validate =)

Yep, that makes sense. Thanks. I have added cases 1 and 2 in an upcoming
patch, and as part of this patch, you could add case 3 as below. Case 4
is just for discussion.


1. Normally

     fs_devices->fsid == fs_devices->metadata_uuid == sb->fsid;
     sb->metadata_uuid == 0;

2. BTRFS_FEATURE_INCOMPAT_METADATA_UUID

     fs_devices->fsid == sb->fsid;
     fs_devices->metadata_uuid == sb->metadata_uuid;


3. BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV

     fs_devices->fsid == random();
     fs_devices->metadata_uuid = sb->fsid;
     sb->metadata_uuid == 0;



For future development: (ignore for now)

4. BTRFS_FEATURE_INCOMPAT_METADATA_UUID |\
     BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV

     fs_devices->fsid == random();
     sb->fsid == actual_fsid (unused);
     fs_devices->metadata_uuid == sb->metadata_uuid;




> @@ -2380,7 +2381,21 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>   		ret = -EINVAL;
>   	}
>   
> -	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE) != 0) {
> +	/*
> +	 * For SINGLE_DEV devices, btrfs creates a random fsid and makes
> +	 * use of the metadata_uuid infrastructure in order to allow, for
> +	 * example, two devices with same fsid getting mounted at the same
> +	 * time. But notice no changes happen at the disk level, the random
> +	 * generated fsid is a driver abstraction, not written to the disk.
> +	 * That's the reason we're required here to compare the fsid  with
> +	 * the metadata_uuid for such devices.
> +	 */
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV))
> +		fsid = fs_info->fs_devices->metadata_uuid;
> +	else
> +		fsid = fs_info->fs_devices->fsid;
> +


> +	if (memcmp(fsid, sb->fsid, BTRFS_FSID_SIZE) != 0) {
>   		btrfs_err(fs_info,
>   		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
>   			  sb->fsid, fs_info->fs_devices->fsid);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index a523d64d5491..cad761f81932 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -198,7 +198,8 @@ enum {
>   	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
>   	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
>   	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
> -	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
> +	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE |	\
> +	 BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV)
>   
>   #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
>   #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a895d105464b..23eb15869cb5 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2678,6 +2678,12 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");


No \n at the end. btrfs_err() already adds one.

> +		return -EINVAL;
> +	}
> +
>   	vol_args = memdup_user(arg, sizeof(*vol_args));
>   	if (IS_ERR(vol_args))
>   		return PTR_ERR(vol_args);
> @@ -2744,6 +2750,12 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");

here too.

> +		return -EINVAL;
> +	}
> +
>   	vol_args = memdup_user(arg, sizeof(*vol_args));
>   	if (IS_ERR(vol_args))
>   		return PTR_ERR(vol_args);
> @@ -3268,6 +3280,12 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device replace is unsupported on SINGLE_DEV devices\n");

and here.

> +		return -EINVAL;
> +	}
> +
>   	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>   		btrfs_err(fs_info, "device replace not supported on extent tree v2 yet");
>   		return -EINVAL;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index cffdd6f7f8e8..5e20e7337261 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -889,7 +889,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
>   				error = -ENOMEM;
>   				goto out;
>   			}
> -			device = btrfs_scan_one_device(device_name, flags);

> +			device = btrfs_scan_one_device(device_name, flags, true);

Why do we have to pass 'true' in btrfs_scan_one_device() here? It is
single device and I don't see any special handle for the seed device.


>   			kfree(device_name);
>   			if (IS_ERR(device)) {
>   				error = PTR_ERR(device);


> @@ -1484,7 +1484,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>   		goto error_fs_info;
>   	}
>   
> -	device = btrfs_scan_one_device(device_name, mode);
> +	device = btrfs_scan_one_device(device_name, mode, true);
>   	if (IS_ERR(device)) {
>   		mutex_unlock(&uuid_mutex);
>   		error = PTR_ERR(device);



> @@ -2196,7 +2196,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   	switch (cmd) {
>   	case BTRFS_IOC_SCAN_DEV:
>   		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>   		ret = PTR_ERR_OR_ZERO(device);
>   		mutex_unlock(&uuid_mutex);
>   		break;
> @@ -2210,7 +2210,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   		break;
>   	case BTRFS_IOC_DEVICES_READY:
>   		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>   		if (IS_ERR(device)) {
>   			mutex_unlock(&uuid_mutex);
>   			ret = PTR_ERR(device);

With this patch, command 'btrfs device scan' and 'btrfs device ready'
returns -EINVAL for the single-device?  Some os distributions checks
the status using these commands during boot. Instead, it is ok to
just return success here.



> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index b1d1ac25237b..5294064ffc64 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -290,6 +290,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
>   BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
>   BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>   BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
> +BTRFS_FEAT_ATTR_COMPAT_RO(single_dev, SINGLE_DEV);
>   BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
>   #ifdef CONFIG_BLK_DEV_ZONED
>   BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
> @@ -322,6 +323,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>   	BTRFS_FEAT_ATTR_PTR(free_space_tree),
>   	BTRFS_FEAT_ATTR_PTR(raid1c34),
>   	BTRFS_FEAT_ATTR_PTR(block_group_tree),
> +	BTRFS_FEAT_ATTR_PTR(single_dev),
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	BTRFS_FEAT_ATTR_PTR(zoned),
>   #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 999cb82dd288..b53318d32603 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -763,8 +763,37 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
>   
>   	return NULL;
>   }
> +
> +static void prepare_virtual_fsid(struct btrfs_super_block *disk_super,
> +				 const char *path)
> +{
> +	struct btrfs_fs_devices *fs_devices;
> +	u8 vfsid[BTRFS_FSID_SIZE];
> +	bool dup_fsid = true;
> +
> +	while (dup_fsid) {
> +		dup_fsid = false;
> +		generate_random_uuid(vfsid);
> +
> +		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +			if (!memcmp(vfsid, fs_devices->fsid, BTRFS_FSID_SIZE) ||
> +			    !memcmp(vfsid, fs_devices->metadata_uuid,
> +				    BTRFS_FSID_SIZE))
> +				dup_fsid = true;
> +		}
> +	}
> +
> +	memcpy(disk_super->metadata_uuid, disk_super->fsid, BTRFS_FSID_SIZE);
> +	memcpy(disk_super->fsid, vfsid, BTRFS_FSID_SIZE);
> +
> +	btrfs_info(NULL,
> +		"virtual fsid (%pU) set for SINGLE_DEV device %s (real fsid %pU)\n",
> +		disk_super->fsid, path, disk_super->metadata_uuid);
> +}
> +
>   /*
> - * Add new device to list of registered devices
> + * Add new device to list of registered devices, or in case of a SINGLE_DEV
> + * device, also creates a virtual fsid to cope with same-fsid cases.
>    *
>    * Returns:
>    * device pointer which was just added or updated when successful
> @@ -785,6 +814,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>   	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
>   					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
> +	bool single_dev = (btrfs_super_compat_ro_flags(disk_super) &
> +			BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV);
>   
>   	error = lookup_bdev(path, &path_devt);
>   	if (error) {
> @@ -793,23 +824,32 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		return ERR_PTR(error);
>   	}
>   
> -	if (fsid_change_in_progress) {
> -		if (!has_metadata_uuid)
> -			fs_devices = find_fsid_inprogress(disk_super);
> -		else
> -			fs_devices = find_fsid_changed(disk_super);
> -	} else if (has_metadata_uuid) {
> -		fs_devices = find_fsid_with_metadata_uuid(disk_super);
> +	if (single_dev) {
> +		if (has_metadata_uuid || fsid_change_in_progress) {
> +			btrfs_err(NULL,
> +		"SINGLE_DEV devices don't support the metadata_uuid feature\n");
> +			return ERR_PTR(-EINVAL);

It could right?

> +		}
> +		prepare_virtual_fsid(disk_super, path);
>   	} else {
> -		fs_devices = find_fsid_reverted_metadata(disk_super);
> -		if (!fs_devices)
> -			fs_devices = find_fsid(disk_super->fsid, NULL);
> +		if (fsid_change_in_progress) {
> +			if (!has_metadata_uuid)
> +				fs_devices = find_fsid_inprogress(disk_super);
> +			else
> +				fs_devices = find_fsid_changed(disk_super);
> +		} else if (has_metadata_uuid) {
> +			fs_devices = find_fsid_with_metadata_uuid(disk_super);
> +		} else {
> +			fs_devices = find_fsid_reverted_metadata(disk_super);
> +			if (!fs_devices)
> +				fs_devices = find_fsid(disk_super->fsid, NULL);
> +		}
>   	}
>   
>   
>   	if (!fs_devices) {
>   		fs_devices = alloc_fs_devices(disk_super->fsid);
> -		if (has_metadata_uuid)
> +		if (has_metadata_uuid || single_dev)
>   			memcpy(fs_devices->metadata_uuid,
>   			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>   
> @@ -1357,13 +1397,15 @@ int btrfs_forget_devices(dev_t devt)
>    * and we are not allowed to call set_blocksize during the scan. The superblock
>    * is read via pagecache
>    */
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> +					   bool mounting)
>   {
>   	struct btrfs_super_block *disk_super;
>   	bool new_device_added = false;
>   	struct btrfs_device *device = NULL;
>   	struct block_device *bdev;
>   	u64 bytenr, bytenr_orig;
> +	bool single_dev;
>   	int ret;
>   
>   	lockdep_assert_held(&uuid_mutex);
> @@ -1402,6 +1444,16 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
>   		goto error_bdev_put;
>   	}
>   
> +	single_dev = btrfs_super_compat_ro_flags(disk_super) &
> +			BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV;
> +
> +	if (!mounting && single_dev) {
> +		pr_info("BTRFS: skipped non-mount scan on SINGLE_DEV device %s\n",
> +			path);
> +		btrfs_release_disk_super(disk_super);

leaks bdev?

> +		return ERR_PTR(-EINVAL);

We need to let seed device scan even for the single device.

In fact we can make no-scan required for the any fs with the total_devs 
== 1.

I wrote a patch send it out for the review. So no special handling for
single-device will be required.

Thanks, Anand

> +	}
> +
>   	device = device_list_add(path, disk_super, &new_device_added);
>   	if (!IS_ERR(device) && new_device_added)
>   		btrfs_free_stale_devices(device->devt, device);
> @@ -2391,6 +2443,12 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
>   
>   	args->devid = btrfs_stack_device_id(&disk_super->dev_item);
>   	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
> +
> +	/*
> +	 * Note that SINGLE_DEV devices are not handled in a special way here;
> +	 * device removal/replace is instead forbidden when such feature is
> +	 * present, this note is for future users/readers of this function.
> +	 */
>   	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
>   		memcpy(args->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>   	else
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 2128a032c3b7..1ffeb333c55c 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -611,7 +611,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
>   void btrfs_mapping_tree_free(struct extent_map_tree *tree);
>   int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>   		       blk_mode_t flags, void *holder);
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags);
> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> +					   bool mounting);
>   int btrfs_forget_devices(dev_t devt);
>   void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>   void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index dbb8b96da50d..cb7a7cfe1ea9 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -313,6 +313,13 @@ struct btrfs_ioctl_fs_info_args {
>    */
>   #define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 3)
>   
> +/*
> + * Single devices (as flagged by the corresponding compat_ro flag) only
> + * gets scanned during mount time; also, a random fsid is generated for
> + * them, in order to cope with same-fsid filesystem mounts.
> + */
> +#define BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV		(1ULL << 4)
> +
>   #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
>   #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
>   #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)

