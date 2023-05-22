Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3380870C41F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjEVRVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjEVRU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 13:20:59 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837CD2;
        Mon, 22 May 2023 10:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIf6NCxTee/C4+BDkt5Fa6+w7HkvlMEEsUgtCp5eDkQvqikNXJ5iKPMUnzZGb9dwt39j8laNryMehbXk3K9TTFka1xRXT5Ylyje92z4iPRPa6H4GmE5oKs7J7Sq5SyRKMnNTRGq0r4sRAdXMm1FGq5PYHOezCDQsV67oCNnFG2eZdaJgr+sudGCCQ5vACpz/Gs8frE3Ni0SOi4pDi+HBU1nxVS99oVUhkvCX4lILkjsg5Y4qrS0nKtw1VtbCAXOWYY5ml+fp2uYPpGBzgH7t3IcrGDQASPtg2LCQPu24tMo5uutZakRah2xqCP6FDhntYKzEtUcMnVimTgrffW6t9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT0exS06tbpkISejAj8SD+3R0Lx5OXG1hKzf4KLSaBI=;
 b=dJCr/wyyKXZN6jPKFLvfwmoKtMmgs9YIhvEfXd2ki9Jpl7X5wM8dIvVx3WyJEzuaZD5EX7GRUkdNLlqQd3rq3BFVC7UrKvRmJ640ZaCNUprrs72JmbGrpD87JmkkRVOdJigYJNpUNPa4xdp+QBp4m9DIHMMLWs3Q0lkGC6tPyyMWiNRUY7LIi1jwcI/PhFc5OfUDo7h5QzioTZiZyCS5ngoLvGpD2NrrO/cJsODas0s3F6OZs9//Zf8y6rpnKdJFJTsk2XiQrsEn26LjkzcTozuwN2wVwnEESx8voe+RjRtSm3nwV6suPmgjTXlACh8TVxgwgteMzkT1grckVwBR4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SN6PR01MB3840.prod.exchangelabs.com (2603:10b6:805:19::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 17:20:55 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::ef26:464c:ccdf:ee6b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::ef26:464c:ccdf:ee6b%7]) with mapi id 15.20.6411.027; Mon, 22 May 2023
 17:20:54 +0000
Message-ID: <adb68fab-f251-90d3-afca-e67b77414abb@talpey.com>
Date:   Mon, 22 May 2023 13:20:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: patches to move ksmbd and cifs under new subdirectory
Content-Language: en-US
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAH2r5msVBGuRbv2tEuZWLR6_pSNNaoeihx=CjvgZ7NxwCNqZvA@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <CAH2r5msVBGuRbv2tEuZWLR6_pSNNaoeihx=CjvgZ7NxwCNqZvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:32b::14) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SN6PR01MB3840:EE_
X-MS-Office365-Filtering-Correlation-Id: 056d37d6-3685-4190-ddb7-08db5ae8e64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BdnKc2U0kj7bAPc/KVn2O+xAWbJ7iv8NrY1zXmaUCwTYEDPJAYgv/l30NFvf5i7AZswkZLV841J0n5cPa3G3mRwBWfmR3F6jwrgZcFxYll8QU20R4UbwPmY6zGkVFNU1Ocnw+k7a3aaR8Zoz2y9LLLJeHNE25zoOD4E4BW/+ySalDORjKs9VeC8qbYnp6a5FtHbwvDSLfxaqbsz0psYCY4JK10XQE5sRiI0wXxv4Y/9NNfFdwYAYjyKhtTQDqtgtLyyyxXhJRDjwT14x8YilgSI9bH6g7tiPOqcipIcp2oIX6Mi/mbL3WSR5BAkM0bta+KZkumeVS5A35WWWgoRTdA2/ndUZokmTm7dOjwMQiLX3a/xb76SCMYouFFE+5pssZ0hCigxX+esWb0oeUt/mqngDSPm90Wct4fYxgvVXzw4R6RaFo+skoVbpRKAFPzEuRzukG9SWMVeDB5TiCYBdxR0Mhd+RE3os9LCoMyTQEB0QoIpVFTVSxHPdmVs1FPTHooEwYhqp3gnSBU63K2NtSaPo/sV3aklNVmwJUJfyE027ffcxS1nioxTNYkstNFjiZxbIR2ZN8IBYXc3gi38OCygZBLOuYjWWdh63JsKI+xAsYyPBhSVOGp0Vvy532OKrIwRvP8KFWpb2caCUHB2yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39830400003)(366004)(136003)(451199021)(8936002)(8676002)(5660300002)(83380400001)(2906002)(186003)(38350700002)(2616005)(36756003)(38100700002)(86362001)(31696002)(26005)(6512007)(6506007)(53546011)(4326008)(316002)(66946007)(66476007)(66556008)(31686004)(54906003)(110136005)(478600001)(6486002)(52116002)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytOSVRjZnBESmFSMmh1bXA1NnB5eEptbWlyRHBDdVdZSk5LMkh4SmR3UkZp?=
 =?utf-8?B?ZiszdHJFUVNLMFFtYUlQbENEdmV2N2cyT3hsOUVVZ1c3THpndzEraE5tclNX?=
 =?utf-8?B?ODcvMWdjcXhaWDNhVVp0bWZKWFJWVWhJVng4WlVEVzRqMnVvZ2hRU0hXeDZL?=
 =?utf-8?B?QUVRclpYQWgrRHcvK1luYStTa2hkZkJ4bTJjZ1hTd25yZE44bklQMzJ6WWFz?=
 =?utf-8?B?a2NycmxpQTBpL0tnQi9OUkE1K3NoeXh3cW1OVDQ2bERZOHJpNU5CWmpJV3hL?=
 =?utf-8?B?c2lOa1JKTWdLVEhjNVRHWTVJaHdHVXo4bXJ2Y1RjMGVxdDJmS1o5RURQMlBO?=
 =?utf-8?B?eXk4RHA3dWdpVksyakl0cndNNjVQeFFnM0I4N25pZnBrcjBXZlFHSTlDUzQ4?=
 =?utf-8?B?ZDFYMVBmL3YwNFk0TzFja1k3ZktMcWNWU3NxQ2c3TkdSN1hIaG9aSnJWNFBl?=
 =?utf-8?B?TDlVR1Y4Vng2bThjeFpNalVwOW1OVGk4OHRSZks4SDZQK1Z4UGIrSVhoODJ0?=
 =?utf-8?B?Z2xCTjdRRWlnblFHYWtwU2hJVzVCay9pOTl0NWlmZjNrK0lJL2l2MGdvSGd3?=
 =?utf-8?B?TFg3REd0VHNGTitvMTlzcDJTemp5UDVabUtxNWM5WjdNeHFEN3AvSUdCSjkz?=
 =?utf-8?B?Q0E2T0ZQTktLemFGUC9FS01VZlJRV21SUnZwcVFGdTU3OGVaNlhINGFCWDRW?=
 =?utf-8?B?dzBjTGZsZWh1T2FSMW1qWTYyaWZxQndycHFyTXpSRTlYZytwK0MyaURpcGkx?=
 =?utf-8?B?cUczV2xTWmgwN3pYMjVkWm9MUmg5aDY3Z3pabU8yblgyWWt6Zit3bG1GbjBh?=
 =?utf-8?B?b0xDYmFaaUJGRnlxclFwU0lnT1dtbDVZN0l1OXJOQk81cGVnV1k5bUhXdzJp?=
 =?utf-8?B?OFkzMDRQQ3NERDIxRzViSHluM2lTalVVMWhrVGhEbkt0T3hOSjZHeWdiWmQv?=
 =?utf-8?B?cHUzQnRtV0pJNk5UTkFDU3FhdXhsUi9TN29Ta2Vld09qMG52MkdWL0ZVU3k4?=
 =?utf-8?B?R1N6Z0xRQWJacTB3QzgzRm9mVE9kUy8yS0VUTGNNSzF3Wmg2ajFhK0ZsNjRF?=
 =?utf-8?B?SktHWE95R09pbkNvRWVGNmNzWUExazNqY0kzU2lBaytvbmdXTFV3VHRTQUF5?=
 =?utf-8?B?YnExVGhPMDN2NDJEbzVoNHlVd2UzcXdkK2RBM2xJS1pZNUU3am8xb0xFemxx?=
 =?utf-8?B?b3hGRzdGOFkyL2d5aWhhb21lWEF1RzN0TzV4dkg1VGI5SVFvZi9MeHVRa1ZU?=
 =?utf-8?B?SVQrNzBJL2NHR1EvMXdhdm1xZkUvbzY1SUREL0FrcnlXZjlmVWlubkpUVENE?=
 =?utf-8?B?K21qeWVqcFdLWFJIczl4R0hVMlIyNDZ4RHZZem1OOHVaa2dvNVo1T0hwSkxw?=
 =?utf-8?B?YTJSZ1hvN1IrN1cwUDYwdk5SVUFXb25xSmpnNWtydENyb2Q0VHpFQ21BR1hi?=
 =?utf-8?B?eTlkSVRFUUVCOTcwM1dzc1hvWUFnaDBBbmJqclZHUnlWWG5wOHd1UmFBR2ZK?=
 =?utf-8?B?cmRRMTcxYTBULzFwa3F0S3ZNRjdkNDFhM05HeklINFgzeG5kUE1OOFdFdkNx?=
 =?utf-8?B?dU9LVzFwT2F3TGdra21WOXFLR0tUTHRYaWQ0M2pvSHd5Y3JFS1BoTHRJbTJR?=
 =?utf-8?B?RTBjTzFianpyTTIwMFpVSWsvcFFwOHU1WHpPOVpyaHNHK1BFaXpPbHpmZVdp?=
 =?utf-8?B?TEk3RUVsZ21jZk0yWStLYzR6bm8yNUZiTzdOSFhyWXhQdzg1MlBFZ0RhTkxx?=
 =?utf-8?B?Q1FhWkZxMlBkckRLRU1MVSt4WE9TTy9LTmFyK2d4emNvWlRDQzFJSXdsTzhS?=
 =?utf-8?B?OEtjd1laTVRtUGRJQ1ZJY3U2ek9GMDRyNkt1M2hoalRWYmJHbnl5dGhHMTR5?=
 =?utf-8?B?M1k3K3doSVl5blNhSTdjQUpzRjVMUzVjbXVVVTBHRklZcjhIY3RoNHJ1SnZl?=
 =?utf-8?B?WTJ5MXZwaDdOWFZuRVdFMWpBdDNNN1FxOG42UzBJRisvKzVSVnNyMnJsSUth?=
 =?utf-8?B?TVFISWRFRjBpbit4OWhhNU1QUzZEY1lBMnJ5eUpwM045bXdGb0xwbGxGNjVl?=
 =?utf-8?B?WkEyRWorY0c1MDJjbW9raTZQbURkTklUUFZmY21TaFlEeGxFK1NpZVQ1MCti?=
 =?utf-8?Q?kHjtTCxmc3QDwwNwcdjZvuBoY?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056d37d6-3685-4190-ddb7-08db5ae8e64e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 17:20:54.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoosrNml1DWhnnWuTyR4uinJWaysiv9ylhzsX92Z4dLTRkNAX2IVS8oI3mVFh5S0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB3840
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/2023 12:33 PM, Steve French wrote:
> Following up on the email thread suggestion to move fs/ksmbd and
> fs/cifs and fs/smbfs_common all under a common directory fs/smb, here
> is an updated
> patchset for that (added one small patch).
> 
> 
>      1) smb3: move Documentation/filesystems/cifs to
> Documentation/filesystems/smb
>      As suggested by Namjae, update the directory for ksmbd/cifs.ko
> Documentation.
>      Documentation/filesystems/cifs contains both server and client information
>      so its pathname is misleading.  In addition, the directory fs/smb
>      now contains both server and client, so move Documentation/filesystems/cifs
>      to Documentation/filesystems/smb
> 
>      Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
> 
> 2) cifs: correct references in Documentation to old fs/cifs path
>      The fs/cifs directory has moved to fs/smb/client, correct mentions
>      of this in Documentation and comments.
> 
> 3)  smb: move client and server files to common directory fs/smb
>     As suggested by Linus, move CIFS/SMB3 related client and server
>     files (cifs.ko and ksmbd.ko and helper modules) to new fs/smb subdirectory:
> 
>         fs/cifs --> fs/smb/client
>         fs/ksmbd --> fs/smb/server
>         fs/smbfs_common --> fs/smb/conmon

There's a typo "conmon" here, which is also present in the changelog.
The "git mv" in the patch is correct.

Regarding the fs/smb/Kconfig, curious why "CIFS" selects SMB_CLIENT?
There's no need to bring in the client in a server-only config.
Or, did this mean to be SMBFS to bring in fs/smb/common instead?
Or, maybe it's time to do away with the "CIFS" option entirely?

config CIFS
  	tristate "SMB3 and CIFS support (advanced network filesystem)"
  	depends on INET
+	select SMB_CLIENT <-- ??
  	select NLS
  	select CRYPTO
  	select CRYPTO_MD5

Either way, is this second SMB_CLIENT=y in fs/smb/Kconfig a typo? Should
it be =m?

+config SMBFS
+	tristate
+	default y if CIFS=y || SMB_CLIENT=y || SMB_SERVER=y
+	default m if CIFS=m || SMB_CLIENT=y  <-- ? || SMB_SERVER=m

Tom.
