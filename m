Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04AF76CF39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjHBNwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjHBNwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:52:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0AAF5
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690984348; x=1722520348;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=WLWdMlFqnzu7nt0OXXCcA2dIiwcW60AbK6aTqQ6zjlA=;
  b=goMF3s4pd4on+Dbm1ZA960fYZFeFCyTLLuXIDdNdepiivANPnSRhDK/s
   Rfz2a2dNPFBNG5kU38REnnJdf3VvcIZJiv28eIUYssZtaK/YuDfrD0GAq
   9EMI/F/RLsFPxnqModFI+tl+CPyl9IPygIGk5yE2hsa6MwGZwH3UVTbwx
   Tu1rFvDNkf1vKi5uImX/y7LfRl4TFj1loqgkFpd+UBrtQJfysMSfkKOfj
   aKnPF/mY9M0os+NbuX6BjnmiWPiTzDqz+2TQQf5gAsWTRtL/gsowpCZGz
   aVvd7Th1kyufkX8Iqy/aXqEDmlLxnCFc+KHo8fQrYYHCehpVOhB2Ehk9t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="369577226"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="yaml'?scan'208";a="369577226"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 06:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732400751"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="yaml'?scan'208";a="732400751"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2023 06:52:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 06:52:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 06:52:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 06:52:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INZGjb4wmr856chXyfwM/vywAOsI/6PsVEF3ejfgTbSDAB0z46eDVgEMNGpl4q9dmnJLSByd7H3DmFmTHfj+c5ZOk8Epn1tZqLtxR74qnx8Ysft8yvKGzgSsPdF9DHpi/7BSGk8KlnWsb7rAWAwIL7mi/1fv8emKCKbVdaq/buoQ7dijW7IoMq3BVtSpnrMP/RctElDTEbMxbrB3V/qV/CaBGBRd5HBUghz+iMwFh3qw4x90h0npyaMhqF64Yq7vxjAl7GhR60aW0W1vCthcJ7eHUc+KiIY2y88SSz+kXqe/VquMfHXxLYXlapR72vtsRMUmhDR6wnMACG0lJ9G14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPxAz98H56Eah8KcX99Yok0noFkEwtowazhYHi3VXoc=;
 b=mg2jpR/YGhaf+BJRoWvIvMKdQoPNgeRdaSab+tx46t3/GDljUPu3nPYsUz7WptMj36GQc+3T8Dqll26oUYvIuqp6ULl785xFQpTFZb7alrs+7VdlGEvXVzGXFMklUz3FQSLKlcXpE80mo6QJFyy4k8Ru6LE10cbenZPQgxfq0HLBwGbi19POktLLtQ4rPHMQWgSh4Q+w7oWULwhcAQLPK3gFAO1k7vG+d6mQn7PBkL0lNtKrEplflrvUsuG9Ca/fo4xVmPgDf4uzyQaZ3FqxsPYYyc8mkZoxuZJRkEfUhZPwi2uL49DC0d7CfMlyslsSC+u+VV/BdvCV+AZyxEUzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB5627.namprd11.prod.outlook.com (2603:10b6:510:e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:52:15 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::1778:c00c:d5ff:da66]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::1778:c00c:d5ff:da66%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:52:15 +0000
Date:   Wed, 2 Aug 2023 21:52:04 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [axboe-block:xfs-async-dio] [fs]  f9f8b03900:
 stress-ng.msg.ops_per_sec 29.3% improvement
Message-ID: <202308022138.a9932885-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="uR47BtlQtO/Ptsyx"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 369b3095-b9ba-42d0-a8a8-08db935fad6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0sRk/DU6jhTa4nh43Kn9VvmH1wxLwaRfhYDwNo4HyX1MwE+/CJ75RYG4DFpjFtx3hDhmhe32Md0sxfXqQGGsIu3vXU6au+b9H8kzhihnuX4AW6wcIjP2zWWmgFuHWKrP0tyb67VI63k3FD+nzF2Tm5T9BoYIN05W6fCkF0u2UpDkFIcfW7FlrZ0Gq/oC65OkWhgVAjrkBteyis9PcaMQbrzdY8LphV6i6pHJR+iBi3tz1FFTf6502u/S72Ze1n6VGZASLtiyQFBZhZYJDWXeOEEH7ZBBzVBXuAZAhfRcQ6OLMTPyiyJRAD+ysFAiownA7tRv8LUTN2MsKdH66OPH87fm4XGw06NX4J3DMbt+JDNaw5G38joIZz3YDexz9RrEgMWF1hxuO6el4ee1mbQErmA1KeclRNcFjX33eh1/KYbO4GlYaGj7tGhHd7JlH6H1nbdVyZl6vC2T3MTvOiHgBHDNnU39AGYkzilX7CRYwNaMZYlFABPD3JbydyMJ2b6kK/v/Hf+gd1ThFrVAHxDXvrVmpVLBlq/DbX4ewHcr8Q575HvDOHMGYEOfelYY+YB7aXfX0t05y+8Ge6jHMGP6wWu41YIQhzdLQRn6aLXcUVb9Eh9CQBJPfh+2plXWHtgNYvg1qcY+OM3uyZTZpt7FInSVRMTmbayUW0Q++NfQ1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(6506007)(38100700002)(26005)(1076003)(478600001)(8936002)(235185007)(5660300002)(8676002)(19627235002)(6916009)(66476007)(66556008)(4326008)(66946007)(6512007)(966005)(86362001)(316002)(41300700001)(44144004)(6666004)(6486002)(2616005)(186003)(21490400003)(82960400001)(107886003)(36756003)(2906002)(30864003)(83380400001)(2700100001)(559001)(579004)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kNuvxWRh3VxxSTTUPWfETq5dgP4tZswhiA62FWRJ3S/sSOHkMICkZU4wTP?=
 =?iso-8859-1?Q?DdjsAw5c8GpWbTQy/4oInRw4B5AhTLGQJpAiIlwwlH8VvDXlYVRHabsS/n?=
 =?iso-8859-1?Q?06jCoXVQaw4QYzSeE8hzqgSu0iJYRp2TGvO0nOGRi+y5gmL05POaPhWULl?=
 =?iso-8859-1?Q?+6e557L3lIUCPoV5V+AZNbjmtlqiMmV+bDe+pUAC+j5JChz0V8B0zwgkPr?=
 =?iso-8859-1?Q?t5mFafztok/OmFmvv6HR7KBfvbIkdwGmeyI6k5mmXlsZiMxZi9c2ob+MxV?=
 =?iso-8859-1?Q?dDfQV955YYdJs9clrS0gxOF59CqUv/n9xVsoQVTaw3vI4d1RtafgjHSkih?=
 =?iso-8859-1?Q?2aaX2sIanIUi3mbqDXxkeLQ+P9gwPwr0rtmlOal4Pgf1WT46FAxhpxfJTO?=
 =?iso-8859-1?Q?ItaWr+Eo6JAn0/dy9pFSJ483XwLlFsSAL6kQfheKSvxKSsMl0sKYE9lhPJ?=
 =?iso-8859-1?Q?WS/iaWNkSqhEBGVlzZcStA/Of426Q+OX6q8TSXT8l+ej7CxVbym0Jm/98b?=
 =?iso-8859-1?Q?XzS9oyYqReOYsSX6/2hPq3Zj5leic2+hCqe9/Sfo/SqRuFzoWeQezgM45x?=
 =?iso-8859-1?Q?D/6tPVaIYfqWZI1HLTkHLTBJ/jbS46XHJrsmLdfQZ2XCWVb+UVc2tvgyro?=
 =?iso-8859-1?Q?+pWA44TsmbrFW1wkfRdEXiKi20PdqQZSnjviXOEoXXAJUQXXzGTkPwx8Wu?=
 =?iso-8859-1?Q?2Imp0UfOBCph7ntmKwmBylsOYmWUwt1bHRMyIS/KGVmHjkL7bY67H+XCqZ?=
 =?iso-8859-1?Q?GZkMrZ42ahCYzXWxJzEt//qp+1o7SHxzkQarxbJ+wJBrbZofgKGzjX5zqf?=
 =?iso-8859-1?Q?ia/MUdamfHCa6QKVwtT2Q54JC0KTHXY7wgeM60mdCZcTftsNK1qenXuEv5?=
 =?iso-8859-1?Q?LxQd9p3DeZ69uQXITqP4tJpYGK4QKn0XT0JCLBUUYvIZnwvNVoBCi4QORb?=
 =?iso-8859-1?Q?OUO947zJ1GDIf1zXTCKdHf3uVaYAAvKTspDHFvS9ofg0PHHpNTLooeU/6f?=
 =?iso-8859-1?Q?zwYhdHwLZqKk4blXCB0pT6Ka8L2+oRxuy9yot1gcKmFI96G7Y+xZqCV00G?=
 =?iso-8859-1?Q?qkV9iFXmjOm5ndjpYtT3iSOjFfgfTFCUKI7Nym3bvPhQ+IfZ2n+KmwN9bG?=
 =?iso-8859-1?Q?9+TzbgdYM1AN/moBAszRdW8Ul6BUs1TRKUvy565xvoIWoXCCiKfPdxRpBn?=
 =?iso-8859-1?Q?f9raJWDOU0lCeL1DRKus84T1ZwCjDOgj+3s/Bp+HyRKAR2NOH9v+JcwcFS?=
 =?iso-8859-1?Q?vENwAnTulRiaRWWLSUAwi2O9KGgpOmm/ELzf72Yy5SxciIzej8CuK+D4Sq?=
 =?iso-8859-1?Q?bOpUh11/enP1lWS+tj+4xP7uHgR3VLGOxetwzZ0l8mDdNuxBwMEUM51jX3?=
 =?iso-8859-1?Q?tS77ndfdiwfDFjRsW40ayLlpW57N2ydu4Zt0aRiVaTMTPzeGwZ7s71Rcl/?=
 =?iso-8859-1?Q?++3qgQyttMI9ekT08w7nfQ6MVvPSpbnfaDO7bzck/nbWXpHiVVA8Ok1I61?=
 =?iso-8859-1?Q?8vw4Jj5mQWJePgkoWtwbJCpQ2KXZ357a8ner1wIs8RB2cxbgiN26/nBO1I?=
 =?iso-8859-1?Q?X4pIHk1GXuc6EoSYXQyezmwJJf2hZTWqOUBISCg8O7DMptWQDOCt/gJ5Zd?=
 =?iso-8859-1?Q?nLyw1nS08DDg8248vFRZIDEBlSXwmQvMYxg838rp167moIL3KfaSMbEg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 369b3095-b9ba-42d0-a8a8-08db935fad6a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:52:15.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkxy1RMb+yMpKXRWuY9mPT9h1aMtciTDuJSJ2bO7Mnd4V4oy5vQhEnRb3DHN6EKknI5waeomTY3OHapAr1fZqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5627
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--uR47BtlQtO/Ptsyx
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


hi, Jens Axboe,

though all results in below formal report are improvement, Fengwei (CCed)
checked on another Intel(R) Xeon(R) Gold 6336Y CPU @ 2.40GHz (Ice Lake)
(sorry, since this machine doesn't belong to our team, we cannot intergrate
the results in our report, only can heads-up you here), and found ~30%
stress-ng.msg.ops_per_sec regression.

but by disable the TRACEPOINT, the regression will disappear.

Fengwei also tried to remove following section from the patch:
@@ -351,7 +361,8 @@ enum rw_hint {
 	{ IOCB_WRITE,		"WRITE" }, \
 	{ IOCB_WAITQ,		"WAITQ" }, \
 	{ IOCB_NOIO,		"NOIO" }, \
-	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }
+	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
+	{ IOCB_DIO_DEFER,	"DIO_DEFER" }

the regression is also gone.

Fengwei also mentioned to us that his understanding is this code update changed
the data section layout of the kernel. Otherwise, it's hard to explain the
regression/improvement this commit could bring.

these information and below formal report FYI.


Hello,

kernel test robot noticed a 29.3% improvement of stress-ng.msg.ops_per_sec on:


commit: f9f8b03900fcd09aa9906ce72627ba23d818ff8d ("fs: add IOCB flags related to passing back dio completions")
https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git xfs-async-dio

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	class: pts
	test: msg
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.msg.ops_per_sec 47.4% improvement                                          |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory      |
| test parameters  | class=pts                                                                                       |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=100%                                                                                 |
|                  | test=msg                                                                                        |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.msg.ops_per_sec 21.0% improvement                                          |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory       |
| test parameters  | class=pts                                                                                       |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=100%                                                                                 |
|                  | test=msg                                                                                        |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.msg.ops_per_sec 47.3% improvement                                          |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory  |
| test parameters  | class=pts                                                                                       |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=100%                                                                                 |
|                  | test=msg                                                                                        |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.msg.ops_per_sec 77.0% improvement                                          |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory     |
| test parameters  | class=pts                                                                                       |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=100%                                                                                 |
|                  | test=msg                                                                                        |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.msg.ops_per_sec 4.1% improvement                                           |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=pts                                                                                       |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=100%                                                                                 |
|                  | test=msg                                                                                        |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pts/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/msg/stress-ng/60s

commit: 
  bb0b988911 ("iomap: complete polled writes inline")
  f9f8b03900 ("fs: add IOCB flags related to passing back dio completions")

bb0b98891149e2f9 f9f8b03900fcd09aa9906ce7262 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   9427553           -16.3%    7888916        cpuidle..usage
      3.10            +0.7        3.76 ±  2%  mpstat.cpu.all.usr%
    268816           -12.2%     235901        vmstat.system.cs
    102711            +7.8%     110717        vmstat.system.in
    449573 ±  7%     +39.5%     627190 ±  2%  numa-numastat.node0.local_node
    488879 ±  7%     +34.1%     655530 ±  3%  numa-numastat.node0.numa_hit
    644832 ±  5%     +12.7%     726508 ±  2%  numa-numastat.node1.numa_hit
    489019 ±  7%     +34.1%     655634 ±  3%  numa-vmstat.node0.numa_hit
    449713 ±  7%     +39.5%     627294 ±  2%  numa-vmstat.node0.numa_local
    644994 ±  5%     +12.6%     726509 ±  2%  numa-vmstat.node1.numa_hit
      9342 ±  4%     +40.5%      13130 ±  8%  perf-c2c.DRAM.remote
     19749 ±  4%     +18.9%      23492 ±  6%  perf-c2c.HITM.local
      7746 ±  5%     +45.0%      11231 ±  8%  perf-c2c.HITM.remote
     27496 ±  4%     +26.3%      34724 ±  7%  perf-c2c.HITM.total
   1135472           +22.0%    1385005        proc-vmstat.numa_hit
   1069207           +23.3%    1318750        proc-vmstat.numa_local
   1178791           +21.1%    1427318        proc-vmstat.pgalloc_normal
    941366           +26.0%    1186234        proc-vmstat.pgfree
      1580 ±  5%     +13.3%       1789 ±  7%  sched_debug.cfs_rq:/.util_avg.max
    153.00 ± 11%     +20.3%     184.05 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      0.00 ± 10%     +32.1%       0.00 ± 21%  sched_debug.cpu.next_balance.stddev
    137625           -10.7%     122897        sched_debug.cpu.nr_switches.avg
 7.053e+08           +27.0%  8.959e+08        stress-ng.msg.ops
  11660227           +29.3%   15071570 ±  2%  stress-ng.msg.ops_per_sec
    144995           +48.5%     215351 ±  6%  stress-ng.time.involuntary_context_switches
      3837            +5.8%       4060        stress-ng.time.percent_of_cpu_this_job_got
      2314            +5.0%       2429        stress-ng.time.system_time
     89.88           +31.9%     118.58        stress-ng.time.user_time
   9197227           -11.2%    8171138        stress-ng.time.voluntary_context_switches
     87808 ±  4%    +162.0%     230038 ±  4%  turbostat.C1
      0.08 ±  4%      +0.2        0.23 ±  6%  turbostat.C1%
   9056318           -19.9%    7256383        turbostat.C1E
     31.00            -4.6       26.37 ±  2%  turbostat.C1E%
    257607 ±  3%     +33.8%     344613 ± 19%  turbostat.C6
      6.60 ±  3%      +1.6        8.24 ± 18%  turbostat.C6%
     14280 ±  4%    +234.0%      47694 ± 10%  turbostat.POLL
      0.01            +0.0        0.02        turbostat.POLL%
    207.60            +2.2%     212.15        turbostat.PkgWatt
     57.13            +4.0%      59.42        turbostat.RAMWatt
      0.01           +35.2%       0.01 ± 39%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
      0.01 ±  4%     +48.5%       0.02 ± 40%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      0.03 ± 35%    +351.2%       0.12 ± 66%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      5.36 ± 13%    +201.8%      16.19 ± 82%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
    195.02 ±  8%     -20.5%     155.12 ± 11%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4.42 ±  5%     -12.5%       3.87        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    188477           -18.4%     153866 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.msgctl_info.constprop
    102397           +16.7%     119478        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
    840.17 ±  4%     +18.1%     992.00 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     10.78 ± 21%    +206.9%      33.08 ± 81%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
    195.01 ±  8%     -20.5%     155.12 ± 11%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.61 ± 24%     -20.2%       0.49 ±  5%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      4.41 ±  5%     -12.7%       3.85        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.20 ± 20%    +166.1%       3.19 ± 50%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      8.21 ± 32%    +122.8%      18.30 ± 83%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.msgctl_info.constprop
      6.96 ± 33%    +127.2%      15.81 ± 71%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
 7.069e+09           +21.7%  8.607e+09        perf-stat.i.branch-instructions
  36091709 ±  2%     +20.1%   43350902 ±  2%  perf-stat.i.branch-misses
     24.62            +3.6       28.20        perf-stat.i.cache-miss-rate%
  51880108           +42.9%   74122572 ±  2%  perf-stat.i.cache-misses
 2.129e+08           +23.1%   2.62e+08 ±  2%  perf-stat.i.cache-references
    284148           -12.3%     249158 ±  2%  perf-stat.i.context-switches
      3.41           -14.8%       2.90        perf-stat.i.cpi
     74997           -17.9%      61596 ±  2%  perf-stat.i.cpu-migrations
      2446           -24.5%       1847 ±  3%  perf-stat.i.cycles-between-cache-misses
 9.169e+09           +21.7%  1.116e+10        perf-stat.i.dTLB-loads
      0.01 ±  4%      -0.0        0.00 ±  8%  perf-stat.i.dTLB-store-miss-rate%
    278645 ±  5%      -7.1%     258884 ±  2%  perf-stat.i.dTLB-store-misses
 5.451e+09           +22.6%  6.685e+09        perf-stat.i.dTLB-stores
 3.689e+10           +21.8%  4.494e+10        perf-stat.i.instructions
      0.31           +14.9%       0.36        perf-stat.i.ipc
    829.38           +38.9%       1152 ±  2%  perf-stat.i.metric.K/sec
    342.15           +21.9%     417.08        perf-stat.i.metric.M/sec
  34062730           +46.0%   49722011 ±  2%  perf-stat.i.node-load-misses
     68.78            +4.7       73.51        perf-stat.i.node-store-miss-rate%
  11986858           +49.5%   17914591 ±  2%  perf-stat.i.node-store-misses
   5276882           +14.2%    6026081        perf-stat.i.node-stores
     24.35            +3.9       28.30        perf-stat.overall.cache-miss-rate%
      3.47           -14.7%       2.96        perf-stat.overall.cpi
      2464           -27.3%       1792        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  5%      -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
      0.29           +17.2%       0.34        perf-stat.overall.ipc
     69.45            +5.4       74.85        perf-stat.overall.node-store-miss-rate%
 6.957e+09           +21.7%  8.467e+09        perf-stat.ps.branch-instructions
  35473007 ±  2%     +20.1%   42597605 ±  2%  perf-stat.ps.branch-misses
  51058535           +42.9%   72971660 ±  2%  perf-stat.ps.cache-misses
 2.097e+08           +23.0%  2.579e+08        perf-stat.ps.cache-references
    279762           -12.4%     245130 ±  2%  perf-stat.ps.context-switches
     73849           -18.0%      60556 ±  2%  perf-stat.ps.cpu-migrations
 9.025e+09           +21.7%  1.098e+10        perf-stat.ps.dTLB-loads
    273876 ±  5%      -7.1%     254328 ±  2%  perf-stat.ps.dTLB-store-misses
 5.366e+09           +22.6%  6.577e+09        perf-stat.ps.dTLB-stores
  3.63e+10           +21.8%  4.422e+10        perf-stat.ps.instructions
  33529406           +46.0%   48951418 ±  2%  perf-stat.ps.node-load-misses
  11798594           +49.5%   17641143 ±  2%  perf-stat.ps.node-store-misses
   5189465           +14.2%    5925881        perf-stat.ps.node-stores
 2.292e+12           +23.7%  2.836e+12        perf-stat.total.instructions
     12.33           -11.2        1.10 ±  2%  perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.66           -10.7        0.99        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.07            -9.8        6.24        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     16.27            -8.9        7.41        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      7.09            -3.0        4.09        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      7.19            -3.0        4.19        perf-profile.calltrace.cycles-pp.msgctl
      7.11            -3.0        4.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msgctl
      7.01            -3.0        4.03        perf-profile.calltrace.cycles-pp.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      3.86            -1.7        2.15        perf-profile.calltrace.cycles-pp.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      1.92            -1.2        0.69 ±  2%  perf-profile.calltrace.cycles-pp.down_read.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.79            -1.2        1.61        perf-profile.calltrace.cycles-pp.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      1.68            -1.0        0.66 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl.do_syscall_64
      1.77            -0.9        0.90 ±  3%  perf-profile.calltrace.cycles-pp.down_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.66            -0.8        0.86 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl.do_syscall_64
      2.92            -0.6        2.29        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      2.87            -0.6        2.25        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.87            -0.6        2.26        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.87            -0.6        2.26        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      1.90            -0.5        1.38        perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      1.90            -0.5        1.39        perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.91            -0.5        1.40        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.90            -0.5        1.40        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.93            -0.5        1.43        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.93            -0.5        1.42        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.95            -0.5        1.45        perf-profile.calltrace.cycles-pp.read
      0.72            -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.msgctl_down.ksys_msgctl.do_syscall_64
      1.82            -0.4        1.40        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.67            -0.4        1.29        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.65            -0.4        1.28        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.30            -0.4        0.94        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.01            -0.3        0.67 ±  2%  perf-profile.calltrace.cycles-pp.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read.ksys_read
      0.96            -0.3        0.64 ±  2%  perf-profile.calltrace.cycles-pp.down_read.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read
      0.80            -0.3        0.52        perf-profile.calltrace.cycles-pp.up_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.88 ±  2%      -0.3        0.62 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.sysvipc_proc_start.seq_read_iter.seq_read
      0.64 ±  2%      -0.2        0.43 ± 44%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.47            -0.1        1.34        perf-profile.calltrace.cycles-pp.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66 ±  2%      -0.1        0.57 ±  2%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl
      0.66            -0.1        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write
      0.66 ±  2%      -0.1        0.56 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      0.52            +0.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.ss_wakeup.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.53            +0.1        0.64        perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgrcv.stress_run
      0.64            +0.2        0.80        perf-profile.calltrace.cycles-pp.__check_object_size.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.78 ±  2%      +0.2        0.98 ±  4%  perf-profile.calltrace.cycles-pp._copy_from_user.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.69            +0.3        0.97 ±  2%  perf-profile.calltrace.cycles-pp.wake_up_q.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.57 ±  2%      +0.4        0.95 ± 27%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgsnd.stress_run
      0.52            +0.4        0.93        perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
     44.31            +0.4       44.75        perf-profile.calltrace.cycles-pp.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      1.56            +0.5        2.01        perf-profile.calltrace.cycles-pp.stress_msg.stress_run
      0.00            +0.5        0.55        perf-profile.calltrace.cycles-pp.__x64_sys_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
     44.91            +0.6       45.47        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__libc_msgsnd.stress_run
      2.40            +0.6        2.99        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     45.12            +0.6       45.73        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      2.24            +0.6        2.88        perf-profile.calltrace.cycles-pp.__list_del_entry_valid.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     45.91            +0.8       46.68        perf-profile.calltrace.cycles-pp.__libc_msgrcv.stress_run
      2.62            +0.8        3.43        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      2.31            +0.8        3.13        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      2.99            +0.8        3.83        perf-profile.calltrace.cycles-pp.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.72            +0.9        4.62        perf-profile.calltrace.cycles-pp._copy_to_user.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      2.54            +1.0        3.50        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.store_msg.do_msg_fill.do_msgrcv
      3.14            +1.2        4.32        perf-profile.calltrace.cycles-pp.__check_object_size.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      3.52            +1.3        4.83        perf-profile.calltrace.cycles-pp.__slab_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.65            +1.6        6.22        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg.do_msgsnd
     36.28            +1.6       37.86        perf-profile.calltrace.cycles-pp.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      4.85            +1.6        6.48        perf-profile.calltrace.cycles-pp.__kmalloc.alloc_msg.load_msg.do_msgsnd.do_syscall_64
      5.16            +1.8        6.98        perf-profile.calltrace.cycles-pp.alloc_msg.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.38            +1.9       39.31        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      6.61            +2.1        8.68        perf-profile.calltrace.cycles-pp.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      2.49            +2.2        4.68        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.26            +2.2        9.49        perf-profile.calltrace.cycles-pp.store_msg.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.78            +2.3       10.11        perf-profile.calltrace.cycles-pp.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      7.15            +2.4        9.53        perf-profile.calltrace.cycles-pp.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     37.98            +2.4       40.37        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      3.17            +2.4        5.61        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     39.21            +2.8       41.99        perf-profile.calltrace.cycles-pp.__libc_msgsnd.stress_run
      6.07            +3.8        9.86        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.90            +4.2       11.06        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     87.54            +4.2       91.74        perf-profile.calltrace.cycles-pp.stress_run
     24.20           -22.1        2.13        perf-profile.children.cycles-pp.idr_find
     32.52           -18.8       13.75        perf-profile.children.cycles-pp.ipc_obtain_object_check
      7.21            -3.0        4.22        perf-profile.children.cycles-pp.msgctl
      7.01            -3.0        4.03        perf-profile.children.cycles-pp.ksys_msgctl
      3.86            -1.7        2.15        perf-profile.children.cycles-pp.msgctl_info
      2.88            -1.5        1.33        perf-profile.children.cycles-pp.down_read
      1.56            -1.4        0.21 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.56            -1.3        1.28        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      2.79            -1.2        1.62        perf-profile.children.cycles-pp.msgctl_down
     91.54            -1.0       90.54        perf-profile.children.cycles-pp.do_syscall_64
      1.77            -0.9        0.90 ±  3%  perf-profile.children.cycles-pp.down_write
      1.66            -0.8        0.86 ±  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.35            -0.7        0.63        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.92            -0.6        2.29        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      2.92            -0.6        2.29        perf-profile.children.cycles-pp.cpu_startup_entry
      2.92            -0.6        2.28        perf-profile.children.cycles-pp.do_idle
      2.87            -0.6        2.26        perf-profile.children.cycles-pp.start_secondary
      1.91            -0.5        1.40        perf-profile.children.cycles-pp.vfs_read
      1.90            -0.5        1.39        perf-profile.children.cycles-pp.seq_read
      1.91            -0.5        1.40        perf-profile.children.cycles-pp.ksys_read
      1.90            -0.5        1.39        perf-profile.children.cycles-pp.seq_read_iter
      1.95            -0.5        1.46        perf-profile.children.cycles-pp.read
     92.26            -0.5       91.77        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.85            -0.4        1.42        perf-profile.children.cycles-pp.cpuidle_idle_call
      0.99            -0.4        0.57        perf-profile.children.cycles-pp.rwsem_wake
      0.51 ±  2%      -0.4        0.10 ±  3%  perf-profile.children.cycles-pp.up_read
      1.69            -0.4        1.30        perf-profile.children.cycles-pp.cpuidle_enter_state
      1.70            -0.4        1.31        perf-profile.children.cycles-pp.cpuidle_enter
      1.33            -0.4        0.95        perf-profile.children.cycles-pp.intel_idle
      1.01            -0.3        0.67 ±  2%  perf-profile.children.cycles-pp.sysvipc_proc_start
      1.03            -0.3        0.74        perf-profile.children.cycles-pp.try_to_wake_up
      0.80            -0.3        0.52        perf-profile.children.cycles-pp.up_write
      0.37            -0.3        0.10 ±  5%  perf-profile.children.cycles-pp.idr_get_next_ul
      0.37 ±  2%      -0.3        0.10 ±  4%  perf-profile.children.cycles-pp.idr_get_next
      3.12            -0.2        2.88 ±  2%  perf-profile.children.cycles-pp.__schedule
      0.45 ±  2%      -0.2        0.23 ±  3%  perf-profile.children.cycles-pp.sysvipc_proc_next
      0.41            -0.2        0.19 ±  7%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.73            -0.2        1.56 ±  2%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      2.78            -0.2        2.60 ±  2%  perf-profile.children.cycles-pp.schedule
      0.66 ±  2%      -0.1        0.52 ±  2%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.48            -0.1        1.35        perf-profile.children.cycles-pp.__percpu_counter_sum
      0.28 ±  2%      -0.1        0.17 ±  3%  perf-profile.children.cycles-pp.msgctl_stat
      0.65            -0.1        0.54 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.55            -0.1        0.46 ±  3%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.15 ±  3%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.42            -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.48            -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.15 ±  2%      -0.1        0.07 ± 18%  perf-profile.children.cycles-pp.osq_lock
      0.50            -0.1        0.43 ±  3%  perf-profile.children.cycles-pp.activate_task
      0.60            -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.49            -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.36            -0.1        0.29 ±  4%  perf-profile.children.cycles-pp.select_task_rq
      0.36 ±  2%      -0.1        0.29 ±  4%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.35            -0.1        0.29        perf-profile.children.cycles-pp.schedule_idle
      0.43            -0.1        0.37 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.31 ±  3%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.15 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.17            -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.wake_affine
      0.12 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.menu_select
      0.17 ±  4%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.select_idle_sibling
      0.16 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.15 ±  3%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.available_idle_cpu
      0.14 ±  2%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.select_idle_cpu
      0.06            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.10 ±  5%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.switch_fpu_return
      0.14 ±  6%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.update_curr
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.task_h_load
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.select_idle_core
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.__switch_to
      0.17 ±  5%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__do_softirq
      0.09            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.11 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.llist_add_batch
      0.08 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.llist_reverse_order
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.__switch_to_asm
      0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.rebalance_domains
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.security_msg_queue_msgrcv
      0.06 ±  6%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.security_msg_queue_msgsnd
      0.13 ±  2%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.06            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__x64_sys_msgrcv
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.10 ±  9%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.format_decode
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.14 ±  2%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.security_ipc_permission
      0.13 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.check_stack_object
      0.10 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.number
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.kmalloc_slab
      0.31 ±  2%      +0.0        0.35        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.19            +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.20 ±  2%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.refill_obj_stock
      0.24 ±  7%      +0.0        0.29 ±  9%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.25            +0.1        0.30        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.29            +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.53            +0.1        0.60 ±  2%  perf-profile.children.cycles-pp.ss_wakeup
      0.32 ±  3%      +0.1        0.39        perf-profile.children.cycles-pp.vsnprintf
      0.32 ±  2%      +0.1        0.39 ±  2%  perf-profile.children.cycles-pp.seq_printf
      0.34 ±  2%      +0.1        0.42        perf-profile.children.cycles-pp.sysvipc_msg_proc_show
      0.33 ±  2%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.24 ±  3%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.security_msg_msg_free
      0.44 ±  3%      +0.1        0.53 ±  8%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.40 ±  3%      +0.1        0.49        perf-profile.children.cycles-pp.__put_user_8
      0.42            +0.1        0.51        perf-profile.children.cycles-pp.__get_user_8
      0.38            +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.__check_heap_object
      0.49            +0.1        0.59        perf-profile.children.cycles-pp.__x64_sys_msgsnd
      0.33 ±  2%      +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.ipcperms
      0.40 ±  2%      +0.1        0.51        perf-profile.children.cycles-pp.kfree
      0.60            +0.1        0.73        perf-profile.children.cycles-pp.mod_objcg_state
      0.64            +0.2        0.80        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.44 ±  2%      +0.2        0.64        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.85            +0.2        1.05        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.79 ±  2%      +0.2        1.00 ±  4%  perf-profile.children.cycles-pp._copy_from_user
      1.12            +0.2        1.37        perf-profile.children.cycles-pp.__entry_text_start
      0.52 ±  2%      +0.4        0.93        perf-profile.children.cycles-pp.___slab_alloc
      1.61            +0.5        2.07        perf-profile.children.cycles-pp.stress_msg
     44.53            +0.5       45.02        perf-profile.children.cycles-pp.do_msgrcv
      2.32            +0.6        2.96        perf-profile.children.cycles-pp.__list_del_entry_valid
      2.64            +0.8        3.46        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      3.02            +0.8        3.87        perf-profile.children.cycles-pp.__kmem_cache_free
     46.33            +0.9       47.20        perf-profile.children.cycles-pp.__libc_msgrcv
      3.82            +0.9        4.76        perf-profile.children.cycles-pp._copy_to_user
      2.97            +1.1        4.04        perf-profile.children.cycles-pp.check_heap_object
      3.54            +1.3        4.85        perf-profile.children.cycles-pp.__slab_free
      4.76            +1.4        6.17        perf-profile.children.cycles-pp.percpu_counter_add_batch
      4.20            +1.5        5.74        perf-profile.children.cycles-pp.__check_object_size
      4.72            +1.6        6.32        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
     36.42            +1.6       38.04        perf-profile.children.cycles-pp.do_msgsnd
      4.89            +1.6        6.54        perf-profile.children.cycles-pp.__kmalloc
      5.18            +1.8        7.01        perf-profile.children.cycles-pp.alloc_msg
      7.32            +2.2        9.56        perf-profile.children.cycles-pp.store_msg
      6.88            +2.3        9.13        perf-profile.children.cycles-pp.load_msg
      7.81            +2.3       10.15        perf-profile.children.cycles-pp.do_msg_fill
      7.24            +2.4        9.69        perf-profile.children.cycles-pp.free_msg
     39.64            +2.9       42.52        perf-profile.children.cycles-pp.__libc_msgsnd
     87.54            +4.2       91.74        perf-profile.children.cycles-pp.stress_run
     10.95            +4.3       15.26        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     10.75            +6.6       17.39        perf-profile.children.cycles-pp._raw_spin_lock
     24.00           -21.9        2.08        perf-profile.self.cycles-pp.idr_find
      1.33            -0.4        0.95        perf-profile.self.cycles-pp.intel_idle
      0.31 ±  2%      -0.3        0.03 ± 70%  perf-profile.self.cycles-pp.down_read
      0.35 ±  2%      -0.3        0.08        perf-profile.self.cycles-pp.idr_get_next_ul
      0.43            -0.2        0.22 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.27 ±  2%      -0.2        0.11 ±  3%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.18 ±  2%      -0.2        0.02 ± 99%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.14 ±  3%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.15 ±  2%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.osq_lock
      0.06 ±  6%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.menu_select
      0.09 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.16 ±  2%      -0.0        0.13        perf-profile.self.cycles-pp.__schedule
      0.28 ±  2%      -0.0        0.25        perf-profile.self.cycles-pp.update_load_avg
      0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.available_idle_cpu
      0.12            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.task_h_load
      0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.09            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.__switch_to
      0.11 ±  3%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.llist_add_batch
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.llist_reverse_order
      0.07 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.__switch_to_asm
      0.06 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.security_msg_queue_msgrcv
      0.06 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.is_vmalloc_addr
      0.06 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__cond_resched
      0.09 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.do_msg_fill
      0.09 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.vsnprintf
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.check_stack_object
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.number
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.alloc_msg
      0.08 ±  6%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.kmalloc_slab
      0.08 ±  8%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.format_decode
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.security_ipc_permission
      0.10 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__kmalloc
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.16 ±  2%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.16 ±  3%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__list_add_valid
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.security_msg_queue_msgsnd
      0.20 ±  2%      +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.50            +0.0        0.55 ±  2%  perf-profile.self.cycles-pp.ss_wakeup
      0.18 ±  3%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.store_msg
      0.19            +0.1        0.24        perf-profile.self.cycles-pp.refill_obj_stock
      0.26            +0.1        0.32 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.22 ±  7%      +0.1        0.28 ±  9%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.30 ±  4%      +0.1        0.36 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.28            +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.33 ±  2%      +0.1        0.40 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.36            +0.1        0.44 ±  2%  perf-profile.self.cycles-pp.__check_heap_object
      0.39 ±  2%      +0.1        0.48        perf-profile.self.cycles-pp.__put_user_8
      0.39            +0.1        0.48        perf-profile.self.cycles-pp.__get_user_8
      0.46            +0.1        0.56        perf-profile.self.cycles-pp.__libc_msgrcv
      0.31 ±  2%      +0.1        0.41 ±  2%  perf-profile.self.cycles-pp.ipcperms
      0.46 ±  2%      +0.1        0.56 ±  2%  perf-profile.self.cycles-pp.__libc_msgsnd
      0.34 ±  2%      +0.1        0.46 ±  2%  perf-profile.self.cycles-pp.kfree
      0.56            +0.1        0.68        perf-profile.self.cycles-pp.mod_objcg_state
      0.24            +0.1        0.38 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.19 ±  3%      +0.2        0.35        perf-profile.self.cycles-pp.free_msg
      0.44 ±  2%      +0.2        0.64        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.76 ±  2%      +0.2        0.95 ±  5%  perf-profile.self.cycles-pp._copy_from_user
      0.82            +0.2        1.02        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.34            +0.2        0.55        perf-profile.self.cycles-pp.load_msg
      0.59            +0.2        0.81        perf-profile.self.cycles-pp.__percpu_counter_sum
      0.85            +0.2        1.07        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.75            +0.3        1.02 ±  2%  perf-profile.self.cycles-pp.wake_up_q
      0.66            +0.3        0.94        perf-profile.self.cycles-pp.__check_object_size
      0.47            +0.4        0.86        perf-profile.self.cycles-pp.___slab_alloc
      1.56            +0.5        2.01        perf-profile.self.cycles-pp.stress_msg
      0.74            +0.5        1.25        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.13            +0.6        2.71        perf-profile.self.cycles-pp._raw_spin_lock
      2.29            +0.6        2.92        perf-profile.self.cycles-pp.__list_del_entry_valid
      2.41            +0.7        3.12        perf-profile.self.cycles-pp.__kmem_cache_free
      2.39            +0.8        3.17        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      3.78            +0.9        4.70        perf-profile.self.cycles-pp._copy_to_user
      2.58            +1.0        3.56        perf-profile.self.cycles-pp.check_heap_object
      3.18            +1.2        4.42        perf-profile.self.cycles-pp.do_msgrcv
      3.50            +1.3        4.80        perf-profile.self.cycles-pp.__slab_free
      4.65            +1.4        6.05        perf-profile.self.cycles-pp.percpu_counter_add_batch
      7.45            +3.2       10.69        perf-profile.self.cycles-pp.ipc_obtain_object_check
      3.18            +3.3        6.49        perf-profile.self.cycles-pp.do_msgsnd
     10.83            +4.3       15.09        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pts/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp2/msg/stress-ng/60s

commit: 
  bb0b988911 ("iomap: complete polled writes inline")
  f9f8b03900 ("fs: add IOCB flags related to passing back dio completions")

bb0b98891149e2f9 f9f8b03900fcd09aa9906ce7262 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     11341 ±  3%     -12.8%       9891 ±  4%  uptime.idle
 4.804e+09 ±  7%     -23.6%   3.67e+09 ±  2%  cpuidle..time
  23134642           +18.2%   27345836        cpuidle..usage
    768774 ±  3%     +11.2%     855179 ±  4%  meminfo.Inactive
    768591 ±  3%     +11.2%     854994 ±  4%  meminfo.Inactive(anon)
    444677 ±  5%     +20.7%     536631 ±  8%  meminfo.Mapped
   1089129 ±  2%     +12.1%    1220580        meminfo.Shmem
     12959 ±  6%     +66.9%      21623 ±  9%  perf-c2c.DRAM.remote
     31796 ±  5%     +41.9%      45134 ±  9%  perf-c2c.HITM.local
      9469 ±  6%     +70.3%      16122 ±  9%  perf-c2c.HITM.remote
     41265 ±  5%     +48.4%      61257 ±  9%  perf-c2c.HITM.total
     56.83 ±  2%     -21.1%      44.83        vmstat.cpu.id
     52.83 ±  6%     +28.1%      67.67        vmstat.procs.r
    589847 ±  3%     +38.8%     818875        vmstat.system.cs
    455431 ±  2%     +24.6%     567654        vmstat.system.in
     55.95 ±  2%     -12.3       43.68        mpstat.cpu.all.idle%
      1.27            +0.2        1.45        mpstat.cpu.all.irq%
      0.06            +0.0        0.07        mpstat.cpu.all.soft%
     40.53 ±  3%     +11.0       51.48        mpstat.cpu.all.sys%
      2.20 ±  3%      +1.1        3.32        mpstat.cpu.all.usr%
 1.366e+09           +49.5%  2.042e+09        stress-ng.msg.ops
  22902604 ±  3%     +47.4%   33748745        stress-ng.msg.ops_per_sec
    208892 ±  5%     -23.6%     159515 ±  4%  stress-ng.time.involuntary_context_switches
      5607           +24.6%       6985        stress-ng.time.percent_of_cpu_this_job_got
      3368           +23.2%       4149        stress-ng.time.system_time
    149.56           +55.4%     232.45        stress-ng.time.user_time
  20243012           +35.3%   27381206        stress-ng.time.voluntary_context_switches
    949438            +3.5%     982203        proc-vmstat.nr_file_pages
    191537 ±  3%     +11.4%     213308 ±  4%  proc-vmstat.nr_inactive_anon
    110510 ±  5%     +20.9%     133639 ±  8%  proc-vmstat.nr_mapped
    272317 ±  2%     +12.1%     305195        proc-vmstat.nr_shmem
    191537 ±  3%     +11.4%     213308 ±  4%  proc-vmstat.nr_zone_inactive_anon
   1286502 ±  2%      +6.9%    1374768        proc-vmstat.numa_hit
   1153877 ±  2%      +7.7%    1242248        proc-vmstat.numa_local
    301049 ±  2%      +9.6%     329829        proc-vmstat.pgactivate
   1349671 ±  2%      +6.4%    1436425        proc-vmstat.pgalloc_normal
      0.01 ± 13%     +41.2%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      1.60 ±  2%     -12.8%       1.40        perf-sched.total_wait_and_delay.average.ms
   1414367           +14.6%    1621115        perf-sched.total_wait_and_delay.count.ms
      1.60 ±  2%     -12.8%       1.39        perf-sched.total_wait_time.average.ms
     79.11 ± 11%     +28.4%     101.54 ± 14%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.70 ±  5%     -13.3%       0.60        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
    549263 ±  3%     +21.5%     667559        perf-sched.wait_and_delay.count.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    290.33 ±  3%     -23.2%     222.83 ±  5%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
    194366 ±  4%     +29.5%     251677        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
     79.11 ± 11%     +28.3%     101.53 ± 14%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.69 ±  5%     -13.4%       0.60        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
      1165 ±  3%     +27.2%       1483        turbostat.Avg_MHz
     44.93 ±  3%     +12.2       57.17        turbostat.Busy%
  23061596           +18.2%   27262715        turbostat.C1
     56.36 ±  2%     -12.2       44.19        turbostat.C1%
     55.07 ±  3%     -22.2%      42.83        turbostat.CPU%c1
      0.15 ±  2%     +16.5%       0.18 ±  2%  turbostat.IPC
  30783263           +22.0%   37562451        turbostat.IRQ
     37889           +31.1%      49671        turbostat.POLL
      0.02            +0.0        0.03        turbostat.POLL%
    328.02            +8.7%     356.41        turbostat.PkgWatt
     39.27           +15.3%      45.26        turbostat.RAMWatt
      0.32 ±  2%     +15.0%       0.37 ±  6%  sched_debug.cfs_rq:/.h_nr_running.avg
      7688 ±  6%     -17.5%       6340 ±  9%  sched_debug.cfs_rq:/.load.stddev
    889477           +65.5%    1471816        sched_debug.cfs_rq:/.min_vruntime.avg
   1079303 ±  6%     +61.6%    1743930 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
    859258           +62.1%    1392649        sched_debug.cfs_rq:/.min_vruntime.min
      0.32 ±  2%     +15.2%       0.36 ±  5%  sched_debug.cfs_rq:/.nr_running.avg
    391.45 ±  2%     +27.9%     500.59 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      1281 ±  6%     +24.9%       1601 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
    262.70 ±  3%     +21.1%     318.04 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
    387.83 ±  2%     +28.3%     497.48 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
      1270 ±  6%     +25.3%       1592 ±  8%  sched_debug.cfs_rq:/.util_avg.max
    260.88 ±  3%     +21.3%     316.36 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     75.58 ±  4%     +52.5%     115.23 ±  8%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    123.15 ±  2%     +15.9%     142.77 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
     31200 ± 20%     -41.8%      18152 ± 35%  sched_debug.cpu.avg_idle.min
      1570 ±  4%     +22.6%       1925 ±  4%  sched_debug.cpu.curr->pid.avg
      0.31 ±  3%     +20.3%       0.37 ±  4%  sched_debug.cpu.nr_running.avg
    151411           +35.0%     204354        sched_debug.cpu.nr_switches.avg
    353407           +14.8%     405586        sched_debug.cpu.nr_switches.max
    117715 ± 11%     +23.4%     145297 ± 10%  sched_debug.cpu.nr_switches.min
 1.333e+10 ±  3%     +48.4%  1.978e+10        perf-stat.i.branch-instructions
  54979651 ±  3%     +60.9%   88488023 ±  4%  perf-stat.i.branch-misses
     18.30 ±  2%      +3.3       21.65 ±  2%  perf-stat.i.cache-miss-rate%
  1.42e+08 ±  4%     +79.8%  2.553e+08        perf-stat.i.cache-misses
 7.611e+08 ±  4%     +53.5%  1.169e+09        perf-stat.i.cache-references
    623413 ±  3%     +39.2%     867972        perf-stat.i.context-switches
      2.18           -15.3%       1.85        perf-stat.i.cpi
 1.532e+11 ±  4%     +27.5%  1.954e+11        perf-stat.i.cpu-cycles
    112789 ±  4%     +66.0%     187199        perf-stat.i.cpu-migrations
      1329 ± 22%     -37.3%     833.22 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.04 ±  3%      -0.0        0.03 ±  4%  perf-stat.i.dTLB-load-miss-rate%
   6989350 ±  5%     +28.1%    8955299 ±  5%  perf-stat.i.dTLB-load-misses
 1.738e+10 ±  4%     +48.6%  2.583e+10        perf-stat.i.dTLB-loads
    594497 ±  6%     +47.2%     875314 ±  2%  perf-stat.i.dTLB-store-misses
 1.029e+10 ±  4%     +51.0%  1.553e+10        perf-stat.i.dTLB-stores
 6.954e+10 ±  3%     +48.8%  1.035e+11        perf-stat.i.instructions
      0.48           +16.2%       0.56        perf-stat.i.ipc
      1.20 ±  4%     +27.5%       1.53        perf-stat.i.metric.GHz
    745.47           +74.6%       1301        perf-stat.i.metric.K/sec
    326.15 ±  4%     +49.2%     486.73        perf-stat.i.metric.M/sec
  58021792 ±  4%     +82.3%  1.058e+08        perf-stat.i.node-load-misses
    621975 ±  8%     +43.6%     893349 ±  5%  perf-stat.i.node-loads
     60.11            +3.7       63.81        perf-stat.i.node-store-miss-rate%
  20117221 ±  4%     +84.7%   37152128        perf-stat.i.node-store-misses
  12372092 ±  4%     +61.9%   20027527        perf-stat.i.node-stores
     18.62            +3.2       21.81 ±  2%  perf-stat.overall.cache-miss-rate%
      2.20           -14.3%       1.89        perf-stat.overall.cpi
      1080           -29.1%     765.74        perf-stat.overall.cycles-between-cache-misses
      0.04 ±  2%      -0.0        0.03 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.45           +16.7%       0.53        perf-stat.overall.ipc
     61.90            +3.1       64.96        perf-stat.overall.node-store-miss-rate%
 1.313e+10 ±  3%     +48.4%  1.948e+10        perf-stat.ps.branch-instructions
  54181550 ±  3%     +61.2%   87331673 ±  4%  perf-stat.ps.branch-misses
 1.398e+08 ±  4%     +79.8%  2.513e+08        perf-stat.ps.cache-misses
 7.506e+08 ±  3%     +53.5%  1.153e+09 ±  2%  perf-stat.ps.cache-references
    614207 ±  3%     +39.2%     854680        perf-stat.ps.context-switches
 1.509e+11 ±  3%     +27.5%  1.924e+11        perf-stat.ps.cpu-cycles
    111164 ±  3%     +65.9%     184416        perf-stat.ps.cpu-migrations
   6859264 ±  5%     +28.3%    8798374 ±  5%  perf-stat.ps.dTLB-load-misses
 1.712e+10 ±  3%     +48.6%  2.545e+10        perf-stat.ps.dTLB-loads
    585518 ±  6%     +47.2%     861661 ±  2%  perf-stat.ps.dTLB-store-misses
 1.014e+10 ±  3%     +50.9%   1.53e+10        perf-stat.ps.dTLB-stores
 6.852e+10 ±  3%     +48.8%   1.02e+11        perf-stat.ps.instructions
  57138653 ±  4%     +82.3%  1.041e+08        perf-stat.ps.node-load-misses
    612726 ±  8%     +43.3%     878165 ±  5%  perf-stat.ps.node-loads
  19809205 ±  4%     +84.6%   36576385        perf-stat.ps.node-store-misses
  12187428 ±  4%     +61.9%   19728175        perf-stat.ps.node-stores
 4.443e+12           +45.7%  6.474e+12        perf-stat.total.instructions
     11.28            -7.0        4.25        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.97            -6.8        4.12        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.10            -6.2        7.90        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     13.95            -6.0        7.94        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     12.75            -4.2        8.54        perf-profile.calltrace.cycles-pp.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
     12.82            -4.2        8.61        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
     12.84            -4.2        8.63        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msgctl
     12.94            -4.2        8.74        perf-profile.calltrace.cycles-pp.msgctl
      8.74            -2.3        6.42        perf-profile.calltrace.cycles-pp.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      3.72            -1.9        1.86 ±  4%  perf-profile.calltrace.cycles-pp.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      2.64            -1.7        0.94 ±  5%  perf-profile.calltrace.cycles-pp.down_read.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.82            -1.7        1.12 ±  8%  perf-profile.calltrace.cycles-pp.down_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.74            -1.6        1.10 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl.do_syscall_64
      2.50            -1.6        0.91 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl.do_syscall_64
      2.69            -1.0        1.72 ±  3%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.68            -1.0        1.71 ±  3%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      2.70            -1.0        1.73 ±  3%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.70            -1.0        1.74 ±  3%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.72            -1.0        1.76 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.72            -1.0        1.76 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      2.74            -1.0        1.79 ±  3%  perf-profile.calltrace.cycles-pp.read
      1.70 ±  2%      -1.0        0.74 ±  7%  perf-profile.calltrace.cycles-pp.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read.ksys_read
      1.65 ±  2%      -1.0        0.70 ±  8%  perf-profile.calltrace.cycles-pp.down_read.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read
      1.59 ±  2%      -0.9        0.69 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.sysvipc_proc_start.seq_read_iter.seq_read
      4.73            -0.6        4.08        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl
      4.82            -0.6        4.18        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64
      5.65            -0.3        5.31        perf-profile.calltrace.cycles-pp.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.23            -0.2        2.98        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.97            -0.2        2.74        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.96            -0.2        2.72        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.86            -0.2        2.63        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.75            -0.2        0.56        perf-profile.calltrace.cycles-pp.up_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.66            -0.2        3.48        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      3.65            -0.2        3.47        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.66            -0.2        3.48        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.68            -0.2        3.52        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.71 ±  2%      -0.1        0.57 ± 44%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      0.70            -0.1        0.57 ± 44%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write
      0.68            -0.1        0.55        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.msgctl_down.ksys_msgctl.do_syscall_64
      1.42            -0.1        1.30        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.57            +0.0        0.61        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.60            +0.0        0.64        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      0.72            +0.1        0.77        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.62 ±  4%      +0.1        0.69 ±  4%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      0.56            +0.1        0.67        perf-profile.calltrace.cycles-pp.mod_objcg_state.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64
      0.52 ±  2%      +0.1        0.63        perf-profile.calltrace.cycles-pp.sysvipc_msg_proc_show.seq_read_iter.seq_read.vfs_read.ksys_read
      0.57            +0.1        0.69        perf-profile.calltrace.cycles-pp.__get_user_8.__x64_sys_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      0.56            +0.1        0.68 ±  2%  perf-profile.calltrace.cycles-pp.__put_user_8.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.02            +0.1        3.15        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.69            +0.1        0.82        perf-profile.calltrace.cycles-pp.__x64_sys_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      0.85            +0.2        1.02        perf-profile.calltrace.cycles-pp.__check_object_size.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.14 ±  2%      +0.2        1.38 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_user.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.38            +0.3        1.68        perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgrcv.stress_run
      1.50            +0.3        1.82        perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgsnd.stress_run
      1.34            +0.4        1.72        perf-profile.calltrace.cycles-pp.stress_msg.stress_run
      1.18 ±  2%      +0.4        1.62        perf-profile.calltrace.cycles-pp.__list_del_entry_valid.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.wake_up_q.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.08 ±223%      +0.5        0.60        perf-profile.calltrace.cycles-pp.seq_printf.sysvipc_msg_proc_show.seq_read_iter.seq_read.vfs_read
      0.00            +0.6        0.55 ±  2%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.load_msg.do_msgsnd.do_syscall_64
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.vsnprintf.seq_printf.sysvipc_msg_proc_show.seq_read_iter.seq_read
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.ss_wakeup.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      3.40            +0.7        4.08        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      2.09            +0.7        2.80        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.store_msg.do_msg_fill.do_msgrcv
      2.45 ±  2%      +0.7        3.19        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      2.83            +0.8        3.60        perf-profile.calltrace.cycles-pp.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.98 ±  2%      +0.8        2.81        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.86            +0.9        3.80        perf-profile.calltrace.cycles-pp.__check_object_size.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      2.71            +1.0        3.67        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      3.15            +1.0        4.14        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      4.56            +1.1        5.70        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg.do_msgsnd
      4.88            +1.2        6.08        perf-profile.calltrace.cycles-pp.__kmalloc.alloc_msg.load_msg.do_msgsnd.do_syscall_64
      3.11            +1.2        4.32        perf-profile.calltrace.cycles-pp.__slab_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.14            +1.3        6.41        perf-profile.calltrace.cycles-pp.alloc_msg.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.58 ± 10%      +1.3        6.88        perf-profile.calltrace.cycles-pp.store_msg.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.62            +1.3       39.94        perf-profile.calltrace.cycles-pp.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      6.35 ±  8%      +1.5        7.82        perf-profile.calltrace.cycles-pp.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     39.45            +1.5       40.94        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
     39.77            +1.6       41.34        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      7.40            +1.7        9.13        perf-profile.calltrace.cycles-pp.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     32.48            +1.9       34.35        perf-profile.calltrace.cycles-pp.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
     41.58            +2.0       43.56        perf-profile.calltrace.cycles-pp.__libc_msgrcv.stress_run
      6.56            +2.2        8.75        perf-profile.calltrace.cycles-pp.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     33.93            +2.2       36.13        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      3.92            +2.3        6.24        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     34.38            +2.4       36.73        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      4.66            +2.6        7.23        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     36.36            +2.9       39.22        perf-profile.calltrace.cycles-pp.__libc_msgsnd.stress_run
     79.41            +5.2       84.64        perf-profile.calltrace.cycles-pp.stress_run
     22.45           -14.0        8.47        perf-profile.children.cycles-pp.idr_find
     28.23           -12.3       15.98        perf-profile.children.cycles-pp.ipc_obtain_object_check
     12.76            -4.2        8.54        perf-profile.children.cycles-pp.ksys_msgctl
     12.97            -4.2        8.78        perf-profile.children.cycles-pp.msgctl
      3.67            -3.0        0.63        perf-profile.children.cycles-pp._raw_spin_lock_irq
      4.30            -2.7        1.65 ±  6%  perf-profile.children.cycles-pp.down_read
      4.09            -2.5        1.60 ±  6%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      8.74            -2.3        6.42        perf-profile.children.cycles-pp.msgctl_info
      3.72            -1.9        1.86 ±  4%  perf-profile.children.cycles-pp.msgctl_down
      2.82            -1.7        1.12 ±  8%  perf-profile.children.cycles-pp.down_write
      2.74            -1.6        1.10 ±  8%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     89.19            -1.4       87.75        perf-profile.children.cycles-pp.do_syscall_64
     89.81            -1.3       88.56        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.33            -1.0        4.33        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.69            -1.0        1.72 ±  3%  perf-profile.children.cycles-pp.seq_read_iter
      2.69            -1.0        1.72 ±  3%  perf-profile.children.cycles-pp.seq_read
      2.70            -1.0        1.73 ±  3%  perf-profile.children.cycles-pp.vfs_read
      2.71            -1.0        1.74 ±  3%  perf-profile.children.cycles-pp.ksys_read
      2.75            -1.0        1.79 ±  3%  perf-profile.children.cycles-pp.read
      1.70 ±  2%      -1.0        0.74 ±  7%  perf-profile.children.cycles-pp.sysvipc_proc_start
      1.04 ±  2%      -0.8        0.24        perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.74 ±  3%      -0.6        0.11 ±  5%  perf-profile.children.cycles-pp.osq_lock
     14.34            -0.5       13.87        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.67            -0.3        5.33        perf-profile.children.cycles-pp.__percpu_counter_sum
      0.42            -0.3        0.08 ±  5%  perf-profile.children.cycles-pp.up_read
      0.90            -0.3        0.60        perf-profile.children.cycles-pp.rwsem_wake
      1.27            -0.2        1.03 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      3.26            -0.2        3.02        perf-profile.children.cycles-pp.cpuidle_idle_call
      2.98            -0.2        2.75        perf-profile.children.cycles-pp.cpuidle_enter_state
      2.88            -0.2        2.66        perf-profile.children.cycles-pp.acpi_idle_enter
      2.99            -0.2        2.76        perf-profile.children.cycles-pp.cpuidle_enter
      2.88            -0.2        2.65        perf-profile.children.cycles-pp.acpi_safe_halt
      0.75            -0.2        0.56        perf-profile.children.cycles-pp.up_write
      3.66            -0.2        3.48        perf-profile.children.cycles-pp.start_secondary
      3.68            -0.2        3.51        perf-profile.children.cycles-pp.do_idle
      3.68            -0.2        3.52        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      3.68            -0.2        3.52        perf-profile.children.cycles-pp.cpu_startup_entry
      0.34 ±  2%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.idr_get_next_ul
      0.34 ±  2%      -0.1        0.21 ±  3%  perf-profile.children.cycles-pp.idr_get_next
      0.19            -0.1        0.07        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.38            -0.1        0.28        perf-profile.children.cycles-pp.sysvipc_proc_next
      0.93            -0.1        0.84 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.74            -0.1        0.69 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.73            -0.1        0.68 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.25 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.25            -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.22 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.msgctl_stat
      0.14 ±  2%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.14 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.07 ±  8%      -0.0        0.05        perf-profile.children.cycles-pp.ktime_get
      0.13 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__do_softirq
      0.16 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.wake_q_add
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.__switch_to
      0.11 ±  3%      +0.0        0.12        perf-profile.children.cycles-pp.update_curr
      0.07            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.ktime_get_real_seconds
      0.08 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.11            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      0.09 ±  5%      +0.0        0.10        perf-profile.children.cycles-pp.prepare_task_switch
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.update_rq_clock
      0.08 ±  8%      +0.0        0.10        perf-profile.children.cycles-pp.__x64_sys_msgrcv
      0.16 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.07 ±  6%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.msgrcv@plt
      0.09 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.security_msg_queue_msgsnd
      0.11 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.security_msg_queue_msgrcv
      0.24            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.14 ±  4%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.kmalloc_slab
      0.14 ±  3%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp._find_next_or_bit
      0.16 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.13 ±  3%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.security_msg_msg_alloc
      0.07            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.finish_task_switch
      0.30            +0.0        0.33 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.17 ±  3%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.format_decode
      0.04 ± 45%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.14 ±  2%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.select_idle_cpu
      0.17 ±  2%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.number
      0.12 ±  4%      +0.0        0.15 ±  6%  perf-profile.children.cycles-pp.update_cfs_group
      0.16 ±  3%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
      0.18 ±  3%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.check_stack_object
      0.35            +0.0        0.39 ±  2%  perf-profile.children.cycles-pp.activate_task
      0.17 ±  4%      +0.0        0.21 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__memcpy
      0.18 ±  3%      +0.0        0.22        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.40            +0.0        0.45 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.28 ±  2%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.22 ±  5%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
      0.22 ±  3%      +0.0        0.26        perf-profile.children.cycles-pp.security_ipc_permission
      0.09 ±  5%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.select_idle_core
      0.29 ±  2%      +0.0        0.34        perf-profile.children.cycles-pp.select_task_rq
      0.33 ±  3%      +0.0        0.38        perf-profile.children.cycles-pp.dequeue_task_fair
      0.32 ±  2%      +0.0        0.38 ±  3%  perf-profile.children.cycles-pp.schedule_idle
      0.29 ±  2%      +0.0        0.34        perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.set_task_cpu
      0.63            +0.1        0.68        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.35            +0.1        0.41 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.29 ±  2%      +0.1        0.35        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.20 ± 14%      +0.1        0.26        perf-profile.children.cycles-pp.security_msg_msg_free
      0.49            +0.1        0.55        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.38            +0.1        0.44        perf-profile.children.cycles-pp.update_load_avg
      0.60            +0.1        0.67        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.75            +0.1        0.82        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.28 ±  2%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.refill_obj_stock
      0.66 ±  4%      +0.1        0.73 ±  4%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.33            +0.1        0.41 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.24 ±  2%      +0.1        0.33        perf-profile.children.cycles-pp.__list_add_valid
      0.44 ±  2%      +0.1        0.52        perf-profile.children.cycles-pp.__virt_addr_valid
      0.49 ±  2%      +0.1        0.59        perf-profile.children.cycles-pp.vsnprintf
      0.37            +0.1        0.48        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.50            +0.1        0.60        perf-profile.children.cycles-pp.seq_printf
      1.93            +0.1        2.04        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.32            +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.78 ±  2%      +0.1        0.90 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      0.52            +0.1        0.64        perf-profile.children.cycles-pp.sysvipc_msg_proc_show
      0.56 ±  2%      +0.1        0.67 ±  2%  perf-profile.children.cycles-pp.__check_heap_object
      0.56 ±  2%      +0.1        0.69        perf-profile.children.cycles-pp.ipcperms
      0.63            +0.1        0.76        perf-profile.children.cycles-pp.__put_user_8
      0.65            +0.1        0.78 ±  2%  perf-profile.children.cycles-pp.__get_user_8
      0.42 ±  7%      +0.1        0.56 ±  2%  perf-profile.children.cycles-pp.kfree
      0.74            +0.2        0.90        perf-profile.children.cycles-pp.__x64_sys_msgsnd
      0.74            +0.2        0.90        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.50            +0.2        0.68        perf-profile.children.cycles-pp.ss_wakeup
      0.92            +0.2        1.11        perf-profile.children.cycles-pp.mod_objcg_state
      1.16 ±  2%      +0.2        1.40 ±  2%  perf-profile.children.cycles-pp._copy_from_user
      1.32            +0.3        1.61        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.28            +0.3        1.58        perf-profile.children.cycles-pp.wake_up_q
      1.70            +0.4        2.07        perf-profile.children.cycles-pp.__entry_text_start
      1.40            +0.4        1.80        perf-profile.children.cycles-pp.stress_msg
      1.24 ±  2%      +0.4        1.69        perf-profile.children.cycles-pp.__list_del_entry_valid
      2.48 ±  2%      +0.7        3.23        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      2.89            +0.8        3.67        perf-profile.children.cycles-pp.__kmem_cache_free
      2.64            +0.8        3.48        perf-profile.children.cycles-pp.check_heap_object
      4.67            +1.2        5.83        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      4.95            +1.2        6.16        perf-profile.children.cycles-pp.__kmalloc
      3.13            +1.2        4.35        perf-profile.children.cycles-pp.__slab_free
      4.10            +1.3        5.35        perf-profile.children.cycles-pp.__check_object_size
      5.17            +1.3        6.45        perf-profile.children.cycles-pp.alloc_msg
      5.65 ±  9%      +1.3        6.96        perf-profile.children.cycles-pp.store_msg
     38.89            +1.4       40.27        perf-profile.children.cycles-pp.do_msgrcv
      6.40 ±  8%      +1.5        7.89        perf-profile.children.cycles-pp.do_msg_fill
      6.62            +1.7        8.30        perf-profile.children.cycles-pp.percpu_counter_add_batch
      7.58            +1.8        9.36        perf-profile.children.cycles-pp.load_msg
     32.69            +1.9       34.62        perf-profile.children.cycles-pp.do_msgsnd
     41.60            +2.0       43.59        perf-profile.children.cycles-pp.__libc_msgrcv
      6.62            +2.2        8.82        perf-profile.children.cycles-pp.free_msg
     36.45            +2.9       39.32        perf-profile.children.cycles-pp.__libc_msgsnd
      7.84            +3.6       11.46        perf-profile.children.cycles-pp._raw_spin_lock
     79.41            +5.2       84.64        perf-profile.children.cycles-pp.stress_run
     22.28           -13.9        8.37        perf-profile.self.cycles-pp.idr_find
      0.73 ±  3%      -0.6        0.11 ±  3%  perf-profile.self.cycles-pp.osq_lock
     14.23            -0.5       13.71        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.25 ±  2%      -0.2        0.05        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.36            -0.2        0.18 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.21 ±  3%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.down_read
      0.34            -0.2        0.20 ±  2%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.31 ±  2%      -0.1        0.18 ±  4%  perf-profile.self.cycles-pp.idr_get_next_ul
      1.63            -0.1        1.50        perf-profile.self.cycles-pp.acpi_safe_halt
      0.18            -0.1        0.06        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.12 ±  5%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.10 ±  3%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.14 ±  4%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.10 ±  3%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.wake_q_add
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.__switch_to
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      0.11 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.07            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.security_msg_queue_msgsnd
      0.09 ±  5%      +0.0        0.11        perf-profile.self.cycles-pp.security_msg_queue_msgrcv
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.kmalloc_slab
      0.10 ±  5%      +0.0        0.12        perf-profile.self.cycles-pp._find_next_or_bit
      0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.msgctl_info
      0.11 ±  4%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.security_msg_msg_alloc
      0.12 ±  3%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.available_idle_cpu
      0.12 ±  4%      +0.0        0.14        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10 ±  3%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.09 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__x64_sys_msgsnd
      0.13 ±  2%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.format_decode
      0.14 ±  5%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.alloc_msg
      0.12 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.vsnprintf
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.check_stack_object
      0.12 ± 19%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.security_msg_msg_free
      0.17 ±  2%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.__kmalloc
      0.15 ±  3%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.number
      0.12 ±  4%      +0.0        0.15 ±  6%  perf-profile.self.cycles-pp.update_cfs_group
      0.20 ±  2%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.28 ±  2%      +0.0        0.32 ±  5%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.18 ±  3%      +0.0        0.22        perf-profile.self.cycles-pp.security_ipc_permission
      0.15 ±  2%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.do_msg_fill
      0.12 ±  8%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.free_msg
      0.20 ±  3%      +0.0        0.25        perf-profile.self.cycles-pp.___slab_alloc
      0.19 ±  3%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.store_msg
      0.24 ±  2%      +0.0        0.29 ±  2%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.20 ±  2%      +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.msgctl
      0.28 ±  2%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.26 ±  2%      +0.1        0.32        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.26 ±  3%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.refill_obj_stock
      0.40 ±  2%      +0.1        0.48        perf-profile.self.cycles-pp.__virt_addr_valid
      0.22            +0.1        0.30        perf-profile.self.cycles-pp.__list_add_valid
      0.06 ± 11%      +0.1        0.15 ± 12%  perf-profile.self.cycles-pp.try_to_wake_up
      0.36            +0.1        0.45        perf-profile.self.cycles-pp.do_syscall_64
      0.32 ±  2%      +0.1        0.41        perf-profile.self.cycles-pp.load_msg
      0.46            +0.1        0.56        perf-profile.self.cycles-pp.__entry_text_start
      0.37            +0.1        0.48        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.52 ±  2%      +0.1        0.63        perf-profile.self.cycles-pp.__check_heap_object
      0.32            +0.1        0.43 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.52 ±  2%      +0.1        0.64        perf-profile.self.cycles-pp.ipcperms
      0.61 ±  2%      +0.1        0.73        perf-profile.self.cycles-pp.__get_user_8
      0.61            +0.1        0.73 ±  2%  perf-profile.self.cycles-pp.__put_user_8
      0.36 ±  6%      +0.1        0.49        perf-profile.self.cycles-pp.kfree
      0.70 ±  2%      +0.2        0.86        perf-profile.self.cycles-pp.__libc_msgsnd
      0.69            +0.2        0.85 ±  2%  perf-profile.self.cycles-pp.__libc_msgrcv
      0.47            +0.2        0.64        perf-profile.self.cycles-pp.ss_wakeup
      0.87            +0.2        1.05        perf-profile.self.cycles-pp.mod_objcg_state
      0.45            +0.2        0.64        perf-profile.self.cycles-pp.wake_up_q
      0.65            +0.2        0.84        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.89            +0.2        1.09 ±  2%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      1.12 ±  2%      +0.2        1.35 ±  2%  perf-profile.self.cycles-pp._copy_from_user
      0.74            +0.2        0.98        perf-profile.self.cycles-pp.__check_object_size
      0.73            +0.3        1.00        perf-profile.self.cycles-pp.__percpu_counter_sum
      1.28            +0.3        1.56        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.35            +0.4        1.72        perf-profile.self.cycles-pp.stress_msg
      1.22 ±  2%      +0.4        1.66        perf-profile.self.cycles-pp.__list_del_entry_valid
      1.91            +0.5        2.37        perf-profile.self.cycles-pp._raw_spin_lock
      2.00            +0.6        2.58        perf-profile.self.cycles-pp.__kmem_cache_free
      2.12 ±  2%      +0.7        2.78        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      2.05            +0.7        2.76        perf-profile.self.cycles-pp.check_heap_object
      2.47            +0.8        3.28        perf-profile.self.cycles-pp.do_msgrcv
      3.10            +1.2        4.30        perf-profile.self.cycles-pp.__slab_free
      4.49            +1.6        6.13        perf-profile.self.cycles-pp.ipc_obtain_object_check
      6.48            +1.6        8.12        perf-profile.self.cycles-pp.percpu_counter_add_batch
      2.10            +2.5        4.59        perf-profile.self.cycles-pp.do_msgsnd



***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pts/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp9/msg/stress-ng/60s

commit: 
  bb0b988911 ("iomap: complete polled writes inline")
  f9f8b03900 ("fs: add IOCB flags related to passing back dio completions")

bb0b98891149e2f9 f9f8b03900fcd09aa9906ce7262 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  15981175           -14.4%   13681038        cpuidle..usage
      3.41 ±  2%      +0.6        4.05 ±  2%  mpstat.cpu.all.usr%
      7960 ±  3%     -36.7%       5041 ± 28%  numa-meminfo.node1.PageTables
    553027 ±  7%     +17.7%     651068 ± 10%  numa-numastat.node0.local_node
    631151 ±  8%     +26.4%     797497 ±  6%  numa-numastat.node1.numa_hit
    496505 ±  2%      -9.2%     450703        vmstat.system.cs
    328948 ±  2%      -6.8%     306707        vmstat.system.in
    553097 ±  7%     +17.7%     651263 ± 10%  numa-vmstat.node0.numa_local
      1989 ±  3%     -36.7%       1260 ± 28%  numa-vmstat.node1.nr_page_table_pages
    631224 ±  8%     +26.3%     797526 ±  6%  numa-vmstat.node1.numa_hit
     95.83 ± 13%     -27.5%      69.50 ±  9%  perf-c2c.DRAM.local
     10770 ±  8%     +20.1%      12930 ±  4%  perf-c2c.DRAM.remote
      8227 ±  8%     +23.6%      10169 ±  4%  perf-c2c.HITM.remote
     30693 ±  8%     +14.7%      35193 ±  4%  perf-c2c.HITM.total
     16146 ± 20%     +24.0%      20025 ± 13%  sched_debug.cfs_rq:/.load.avg
    120.68 ±  9%     +25.6%     151.54 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    604.33 ± 11%     +28.4%     776.08 ± 15%  sched_debug.cfs_rq:/.util_est_enqueued.max
    145.38 ±  4%     +18.1%     171.71 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    215031 ±  4%     -11.3%     190647 ±  2%  sched_debug.cpu.nr_switches.min
  15931635           -14.4%   13635514        turbostat.C1
      0.16 ±  3%     +15.1%       0.18 ±  2%  turbostat.IPC
     28970           -16.1%      24305        turbostat.POLL
      0.03            -0.0        0.02        turbostat.POLL%
    350.07            +2.6%     359.01        turbostat.PkgWatt
     68.37            +3.9%      71.07        turbostat.RAMWatt
      0.01           +20.0%       0.01        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
      0.01           +16.7%       0.01        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      0.44            -9.8%       0.40        perf-sched.wait_and_delay.avg.ms.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    325.50 ±  3%     -11.0%     289.83 ±  7%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
    358894           -10.1%     322676        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.msgctl_info.constprop
    181104           +13.8%     206014        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
      0.43            -9.8%       0.39        perf-sched.wait_time.avg.ms.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    200399 ±  2%      +5.5%     211387        proc-vmstat.nr_active_anon
    257764            +2.1%     263230        proc-vmstat.nr_shmem
    200399 ±  2%      +5.5%     211387        proc-vmstat.nr_zone_active_anon
   1241496           +19.0%    1477593        proc-vmstat.numa_hit
   1175233           +20.1%    1411311        proc-vmstat.numa_local
   1282939           +18.7%    1522979        proc-vmstat.pgalloc_normal
    878959           +26.6%    1113084        proc-vmstat.pgfree
 1.317e+09           +21.4%  1.598e+09        stress-ng.msg.ops
  21806352           +21.0%   26393300        stress-ng.msg.ops_per_sec
    542357           -25.4%     404790        stress-ng.time.involuntary_context_switches
      3700            +4.4%       3863        stress-ng.time.percent_of_cpu_this_job_got
      2199            +3.5%       2276        stress-ng.time.system_time
    118.77           +23.8%     146.98        stress-ng.time.user_time
  17290736            -8.9%   15749560        stress-ng.time.voluntary_context_switches
 1.245e+10 ±  2%     +19.1%  1.482e+10 ±  2%  perf-stat.i.branch-instructions
  55001886 ±  2%     +16.5%   64082388 ±  2%  perf-stat.i.branch-misses
     22.63            +2.0       24.68        perf-stat.i.cache-miss-rate%
 1.547e+08 ±  2%     +29.0%  1.996e+08 ±  2%  perf-stat.i.cache-misses
 6.668e+08 ±  2%     +18.6%   7.91e+08 ±  2%  perf-stat.i.cache-references
    523552 ±  2%      -9.0%     476415 ±  2%  perf-stat.i.context-switches
      2.14           -12.4%       1.87        perf-stat.i.cpi
    126489 ±  2%     -10.7%     112943 ±  2%  perf-stat.i.cpu-migrations
 1.625e+10 ±  2%     +19.1%  1.935e+10 ±  2%  perf-stat.i.dTLB-loads
 9.834e+09 ±  2%     +19.7%  1.178e+10 ±  2%  perf-stat.i.dTLB-stores
 6.517e+10 ±  2%     +19.2%  7.767e+10 ±  2%  perf-stat.i.instructions
      0.49           +13.1%       0.55        perf-stat.i.ipc
      1083 ± 20%     -35.0%     704.90        perf-stat.i.metric.K/sec
    612.77 ±  2%     +19.3%     731.30 ±  2%  perf-stat.i.metric.M/sec
  61149827           +31.0%   80099700 ±  2%  perf-stat.i.node-load-misses
     65.30            +3.2       68.55        perf-stat.i.node-store-miss-rate%
  22437020 ±  2%     +30.6%   29312498 ±  2%  perf-stat.i.node-store-misses
  11096049 ±  2%     +12.3%   12462334 ±  2%  perf-stat.i.node-stores
     23.19            +2.0       25.22        perf-stat.overall.cache-miss-rate%
      2.16           -12.6%       1.89        perf-stat.overall.cpi
    911.34           -19.3%     735.51        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  5%      -0.0        0.00 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
      0.46           +14.5%       0.53        perf-stat.overall.ipc
     66.91            +3.3       70.17        perf-stat.overall.node-store-miss-rate%
 1.225e+10 ±  2%     +19.1%  1.459e+10 ±  2%  perf-stat.ps.branch-instructions
  54143742 ±  2%     +16.5%   63081303 ±  2%  perf-stat.ps.branch-misses
 1.523e+08 ±  2%     +29.0%  1.965e+08 ±  2%  perf-stat.ps.cache-misses
 6.566e+08 ±  2%     +18.7%  7.791e+08 ±  2%  perf-stat.ps.cache-references
    515497 ±  2%      -9.0%     469070 ±  2%  perf-stat.ps.context-switches
    124547 ±  2%     -10.7%     111200 ±  2%  perf-stat.ps.cpu-migrations
   1.6e+10 ±  2%     +19.1%  1.905e+10 ±  2%  perf-stat.ps.dTLB-loads
 9.683e+09 ±  2%     +19.8%   1.16e+10 ±  2%  perf-stat.ps.dTLB-stores
 6.416e+10 ±  2%     +19.2%  7.648e+10 ±  2%  perf-stat.ps.instructions
  60204457           +31.0%   78860646 ±  2%  perf-stat.ps.node-load-misses
  22089721 ±  2%     +30.6%   28859355 ±  2%  perf-stat.ps.node-store-misses
  10924343 ±  2%     +12.3%   12269546 ±  2%  perf-stat.ps.node-stores
 4.133e+12           +19.0%  4.918e+12        perf-stat.total.instructions
      9.05            -7.0        2.02        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.84            -6.9        1.95        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.79            -6.0        6.79        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     12.96            -5.8        7.20        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      7.27            -3.0        4.32        perf-profile.calltrace.cycles-pp.msgctl
      7.13            -2.9        4.19        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      7.15            -2.9        4.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msgctl
      7.06            -2.9        4.12        perf-profile.calltrace.cycles-pp.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      3.94            -1.9        2.04        perf-profile.calltrace.cycles-pp.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      1.94 ±  2%      -1.1        0.80        perf-profile.calltrace.cycles-pp.down_read.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.76 ±  2%      -1.0        0.78        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl.do_syscall_64
      2.77            -1.0        1.80        perf-profile.calltrace.cycles-pp.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      1.88            -0.8        1.13        perf-profile.calltrace.cycles-pp.down_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.39            -0.7        2.68        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      1.80 ±  2%      -0.7        1.10        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl.do_syscall_64
      3.40            -0.6        2.78        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.45            -0.6        2.83        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      3.40            -0.6        2.78        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      3.40            -0.6        2.78        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.96            -0.6        2.39        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.75            -0.5        2.22        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.74            -0.5        2.21        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.66            -0.5        2.15        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.50            -0.4        1.10        perf-profile.calltrace.cycles-pp.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.01            -0.3        1.67        perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.03            -0.3        1.69        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.02            -0.3        1.68        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.01            -0.3        1.67        perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      2.05            -0.3        1.71        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      2.04            -0.3        1.71        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.07            -0.3        1.73        perf-profile.calltrace.cycles-pp.read
      1.01 ±  2%      -0.3        0.72        perf-profile.calltrace.cycles-pp.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read.ksys_read
      0.98 ±  2%      -0.3        0.69        perf-profile.calltrace.cycles-pp.down_read.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read
      0.91 ±  3%      -0.2        0.67        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.sysvipc_proc_start.seq_read_iter.seq_read
      1.26            -0.2        1.04        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.82 ±  2%      -0.1        0.67        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.72 ±  4%      -0.1        0.58        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl
      0.71 ±  4%      -0.1        0.58        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.msgctl_info
      0.70            -0.1        0.58        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      0.68            -0.1        0.55        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.68 ±  3%      +0.0        0.71        perf-profile.calltrace.cycles-pp.__radix_tree_lookup.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68 ±  5%      +0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      1.12 ±  5%      +0.1        1.22        perf-profile.calltrace.cycles-pp.schedule.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      1.11 ±  5%      +0.1        1.21        perf-profile.calltrace.cycles-pp.__schedule.schedule.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60 ±  2%      +0.1        0.70        perf-profile.calltrace.cycles-pp.__put_user_8.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68 ±  7%      +0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      0.76 ±  6%      +0.1        0.86 ±  2%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.do_msgrcv
      0.53            +0.1        0.64        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.load_msg.do_msgsnd.do_syscall_64
      0.60            +0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64
      0.54            +0.1        0.65        perf-profile.calltrace.cycles-pp.sysvipc_msg_proc_show.seq_read_iter.seq_read.vfs_read.ksys_read
      0.76 ±  7%      +0.1        0.87 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_msgrcv.do_syscall_64
      0.61 ±  2%      +0.1        0.73        perf-profile.calltrace.cycles-pp.__get_user_8.__x64_sys_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      0.62            +0.1        0.74        perf-profile.calltrace.cycles-pp.ss_wakeup.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.74            +0.1        0.88        perf-profile.calltrace.cycles-pp.__x64_sys_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      0.45 ± 44%      +0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      2.68            +0.2        2.84        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      0.50 ± 44%      +0.2        0.65 ±  2%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.50 ± 44%      +0.2        0.66 ±  2%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.98            +0.2        1.16        perf-profile.calltrace.cycles-pp.__check_object_size.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.43 ± 44%      +0.2        0.62        perf-profile.calltrace.cycles-pp.seq_printf.sysvipc_msg_proc_show.seq_read_iter.seq_read.vfs_read
      0.68            +0.2        0.90 ±  2%  perf-profile.calltrace.cycles-pp.wake_up_q.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      1.53            +0.3        1.80        perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgrcv.stress_run
      1.61            +0.3        1.93        perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgsnd.stress_run
      2.54            +0.3        2.86        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      1.67            +0.4        2.07        perf-profile.calltrace.cycles-pp.__list_del_entry_valid.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      1.86            +0.4        2.28        perf-profile.calltrace.cycles-pp.stress_msg.stress_run
      2.53            +0.5        3.03        perf-profile.calltrace.cycles-pp._copy_to_user.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      0.08 ±223%      +0.5        0.59        perf-profile.calltrace.cycles-pp.vsnprintf.seq_printf.sysvipc_msg_proc_show.seq_read_iter.seq_read
     42.01            +0.7       42.67        perf-profile.calltrace.cycles-pp.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      3.46            +0.7        4.14        perf-profile.calltrace.cycles-pp.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.81            +0.7        3.54        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.store_msg.do_msg_fill.do_msgrcv
      2.04            +0.7        2.77        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.11            +0.7        3.85        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
     42.93            +0.8       43.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      2.85            +0.9        3.70        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     43.28            +0.9       44.15        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      3.66            +0.9        4.58        perf-profile.calltrace.cycles-pp.__check_object_size.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      4.18            +1.1        5.29        perf-profile.calltrace.cycles-pp.__slab_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.24            +1.2       36.44        perf-profile.calltrace.cycles-pp.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
     45.25            +1.2       46.45        perf-profile.calltrace.cycles-pp.__libc_msgrcv.stress_run
      5.69            +1.3        6.94        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg.do_msgsnd
      6.04            +1.3        7.36        perf-profile.calltrace.cycles-pp.__kmalloc.alloc_msg.load_msg.do_msgsnd.do_syscall_64
      6.35            +1.4        7.78        perf-profile.calltrace.cycles-pp.alloc_msg.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.87            +1.5       38.40        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      6.64            +1.6        8.20        perf-profile.calltrace.cycles-pp.store_msg.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.48            +1.7        9.18        perf-profile.calltrace.cycles-pp.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     37.44            +1.7       39.18        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      8.94            +1.8       10.71        perf-profile.calltrace.cycles-pp.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      8.44            +2.0       10.43        perf-profile.calltrace.cycles-pp.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     39.71            +2.3       41.97        perf-profile.calltrace.cycles-pp.__libc_msgsnd.stress_run
      5.42            +2.4        7.78        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.38            +2.6        8.98        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     86.96            +3.9       90.88        perf-profile.calltrace.cycles-pp.stress_run
     18.08           -14.0        4.05        perf-profile.children.cycles-pp.idr_find
     25.94           -11.8       14.14        perf-profile.children.cycles-pp.ipc_obtain_object_check
      7.30            -3.0        4.35        perf-profile.children.cycles-pp.msgctl
      7.06            -2.9        4.12        perf-profile.children.cycles-pp.ksys_msgctl
      3.94            -1.9        2.04        perf-profile.children.cycles-pp.msgctl_info
      2.92 ±  2%      -1.4        1.49        perf-profile.children.cycles-pp.down_read
      1.52            -1.2        0.27        perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.68 ±  2%      -1.2        1.45        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      2.77            -1.0        1.80        perf-profile.children.cycles-pp.msgctl_down
     89.26            -0.9       88.35        perf-profile.children.cycles-pp.do_syscall_64
      1.33            -0.8        0.49        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.88            -0.8        1.13        perf-profile.children.cycles-pp.down_write
      1.80 ±  2%      -0.7        1.10        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     90.02            -0.7       89.35        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.45            -0.6        2.83        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      3.45            -0.6        2.83        perf-profile.children.cycles-pp.cpu_startup_entry
      3.45            -0.6        2.83        perf-profile.children.cycles-pp.do_idle
      3.40            -0.6        2.78        perf-profile.children.cycles-pp.start_secondary
      3.01            -0.6        2.44        perf-profile.children.cycles-pp.cpuidle_idle_call
      2.79            -0.5        2.26        perf-profile.children.cycles-pp.cpuidle_enter
      2.78            -0.5        2.25        perf-profile.children.cycles-pp.cpuidle_enter_state
      2.69            -0.5        2.18        perf-profile.children.cycles-pp.acpi_safe_halt
      2.70            -0.5        2.19        perf-profile.children.cycles-pp.acpi_idle_enter
      2.22            -0.4        1.80        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.52            -0.4        1.12        perf-profile.children.cycles-pp.__percpu_counter_sum
      0.48            -0.4        0.10 ±  3%  perf-profile.children.cycles-pp.up_read
      2.01            -0.3        1.67        perf-profile.children.cycles-pp.seq_read_iter
      2.01            -0.3        1.67        perf-profile.children.cycles-pp.seq_read
      0.88            -0.3        0.54        perf-profile.children.cycles-pp.rwsem_wake
      2.03            -0.3        1.69        perf-profile.children.cycles-pp.ksys_read
      2.02            -0.3        1.68        perf-profile.children.cycles-pp.vfs_read
      2.07            -0.3        1.74        perf-profile.children.cycles-pp.read
      1.01 ±  2%      -0.3        0.72        perf-profile.children.cycles-pp.sysvipc_proc_start
      0.60            -0.3        0.31 ±  2%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.69            -0.2        0.48        perf-profile.children.cycles-pp.up_write
      0.91            -0.2        0.72        perf-profile.children.cycles-pp.try_to_wake_up
      0.29 ±  2%      -0.2        0.13 ±  3%  perf-profile.children.cycles-pp.idr_get_next_ul
      0.29            -0.2        0.13 ±  4%  perf-profile.children.cycles-pp.idr_get_next
      0.36            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.sysvipc_proc_next
      0.89            -0.1        0.76        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.26            -0.1        0.14 ±  2%  perf-profile.children.cycles-pp.osq_lock
      0.77            -0.1        0.65        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.19            -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.74            -0.1        0.64        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.62            -0.1        0.53        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.54            -0.1        0.47        perf-profile.children.cycles-pp.ttwu_do_activate
      0.25            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.msgctl_stat
      0.49            -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.activate_task
      0.45 ±  3%      -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.15 ±  2%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.42            -0.0        0.38        perf-profile.children.cycles-pp.enqueue_task_fair
      0.32 ±  2%      -0.0        0.28        perf-profile.children.cycles-pp.select_task_rq
      0.31            -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.35 ±  3%      -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.37 ±  2%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.50            -0.0        0.46 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.33            -0.0        0.30        perf-profile.children.cycles-pp.enqueue_entity
      0.16 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.menu_select
      0.11 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.13            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
      0.17 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
      0.18 ±  3%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.select_idle_cpu
      0.15 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.13 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.update_curr
      0.12 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.wake_affine
      0.10 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.09            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.switch_fpu_return
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.set_next_entity
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.10 ±  3%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.finish_task_switch
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp._find_next_or_bit
      0.08 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.ktime_get_real_seconds
      0.10 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.security_msg_queue_msgsnd
      0.16 ±  3%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.security_msg_msg_alloc
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.security_msg_queue_msgrcv
      0.08            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.msgrcv@plt
      0.15 ±  4%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.16 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.kmalloc_slab
      0.17 ±  3%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.18 ±  2%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.number
      0.20 ±  4%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.check_stack_object
      0.24            +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.security_ipc_permission
      0.20 ±  5%      +0.0        0.24        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.40            +0.0        0.44        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.format_decode
      0.41 ±  4%      +0.1        0.46 ±  4%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.32 ±  4%      +0.1        0.38        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.32            +0.1        0.38        perf-profile.children.cycles-pp.refill_obj_stock
      0.28 ±  3%      +0.1        0.34 ±  4%  perf-profile.children.cycles-pp.security_msg_msg_free
      0.37 ±  3%      +0.1        0.44        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.46 ±  2%      +0.1        0.54        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.62 ±  2%      +0.1        0.71        perf-profile.children.cycles-pp.__check_heap_object
      0.31            +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.72 ±  5%      +0.1        0.81 ±  3%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.48            +0.1        0.58 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.52 ±  2%      +0.1        0.62        perf-profile.children.cycles-pp.seq_printf
      0.51 ±  2%      +0.1        0.62        perf-profile.children.cycles-pp.vsnprintf
      0.68            +0.1        0.79        perf-profile.children.cycles-pp.__put_user_8
      0.59            +0.1        0.70        perf-profile.children.cycles-pp.ipcperms
      0.55 ±  2%      +0.1        0.66        perf-profile.children.cycles-pp.sysvipc_msg_proc_show
      0.53            +0.1        0.65        perf-profile.children.cycles-pp.kfree
      0.38 ±  2%      +0.1        0.50        perf-profile.children.cycles-pp.___slab_alloc
      0.63            +0.1        0.76        perf-profile.children.cycles-pp.ss_wakeup
      0.69 ±  2%      +0.1        0.82        perf-profile.children.cycles-pp.__get_user_8
      1.87 ±  7%      +0.1        2.02 ±  2%  perf-profile.children.cycles-pp.load_balance
      0.85            +0.1        1.00        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.80            +0.1        0.95        perf-profile.children.cycles-pp.__x64_sys_msgsnd
      2.02 ±  7%      +0.2        2.18 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      0.40 ±  3%      +0.2        0.56 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.01            +0.2        1.18        perf-profile.children.cycles-pp.mod_objcg_state
      1.44            +0.3        1.71        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.85            +0.3        2.19        perf-profile.children.cycles-pp.__entry_text_start
      1.76            +0.4        2.15        perf-profile.children.cycles-pp.__list_del_entry_valid
      1.93            +0.4        2.38        perf-profile.children.cycles-pp.stress_msg
      5.30            +0.5        5.78        perf-profile.children.cycles-pp.percpu_counter_add_batch
      2.68            +0.5        3.22        perf-profile.children.cycles-pp._copy_to_user
      3.52            +0.7        4.20        perf-profile.children.cycles-pp.__kmem_cache_free
     42.32            +0.7       43.02        perf-profile.children.cycles-pp.do_msgrcv
      3.15            +0.8        3.90        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      3.46            +0.8        4.30        perf-profile.children.cycles-pp.check_heap_object
      4.20            +1.1        5.32        perf-profile.children.cycles-pp.__slab_free
     45.30            +1.2       46.51        perf-profile.children.cycles-pp.__libc_msgrcv
      5.10            +1.3        6.35        perf-profile.children.cycles-pp.__check_object_size
     35.48            +1.3       36.74        perf-profile.children.cycles-pp.do_msgsnd
      5.81            +1.3        7.08        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      6.11            +1.3        7.44        perf-profile.children.cycles-pp.__kmalloc
      6.39            +1.4        7.82        perf-profile.children.cycles-pp.alloc_msg
      9.73            +1.5       11.22        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      6.72            +1.6        8.29        perf-profile.children.cycles-pp.store_msg
      7.54            +1.7        9.26        perf-profile.children.cycles-pp.do_msg_fill
      9.18            +1.9       11.04        perf-profile.children.cycles-pp.load_msg
      8.52            +2.0       10.54        perf-profile.children.cycles-pp.free_msg
     39.79            +2.3       42.06        perf-profile.children.cycles-pp.__libc_msgsnd
      9.82            +3.5       13.32        perf-profile.children.cycles-pp._raw_spin_lock
     86.96            +3.9       90.88        perf-profile.children.cycles-pp.stress_run
     17.95           -14.0        3.99        perf-profile.self.cycles-pp.idr_find
      1.58            -0.3        1.24        perf-profile.self.cycles-pp.acpi_safe_halt
      0.40            -0.2        0.18 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.31 ±  2%      -0.2        0.14        perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.27 ±  3%      -0.2        0.11 ±  4%  perf-profile.self.cycles-pp.idr_get_next_ul
      0.26            -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.osq_lock
      0.18 ±  2%      -0.1        0.06        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.10 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.17 ±  3%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.13 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.13            -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.available_idle_cpu
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.menu_select
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.__update_load_avg_se
      0.11 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.try_to_wake_up
      0.14 ±  3%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.security_msg_msg_alloc
      0.08 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.security_msg_queue_msgsnd
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.security_msg_queue_msgrcv
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.10            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.10 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__x64_sys_msgsnd
      0.13 ±  5%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.17 ±  2%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.number
      0.14 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.kmalloc_slab
      0.15 ±  5%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.alloc_msg
      0.20            +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.security_ipc_permission
      0.13 ±  5%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.vsnprintf
      0.19 ±  3%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.__kmalloc
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.check_stack_object
      0.14 ±  3%      +0.0        0.17        perf-profile.self.cycles-pp.format_decode
      0.17 ±  2%      +0.0        0.20        perf-profile.self.cycles-pp.do_msg_fill
      0.22 ±  3%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.store_msg
      0.23 ±  2%      +0.0        0.28 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.27 ±  4%      +0.0        0.32        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.39 ±  4%      +0.1        0.44 ±  4%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.30            +0.1        0.35        perf-profile.self.cycles-pp.refill_obj_stock
      0.32 ±  3%      +0.1        0.37        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.40            +0.1        0.48        perf-profile.self.cycles-pp.do_syscall_64
      0.18 ±  2%      +0.1        0.25 ±  3%  perf-profile.self.cycles-pp.free_msg
      0.50 ±  4%      +0.1        0.58 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.58 ±  2%      +0.1        0.66        perf-profile.self.cycles-pp.__check_heap_object
      0.28            +0.1        0.37 ±  2%  perf-profile.self.cycles-pp.__list_add_valid
      0.30            +0.1        0.38        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.46 ±  2%      +0.1        0.54        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.44 ±  2%      +0.1        0.53 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.56            +0.1        0.66        perf-profile.self.cycles-pp.__percpu_counter_sum
      0.54            +0.1        0.65        perf-profile.self.cycles-pp.ipcperms
      0.46            +0.1        0.56 ±  2%  perf-profile.self.cycles-pp.kfree
      0.66            +0.1        0.76        perf-profile.self.cycles-pp.__put_user_8
      0.35            +0.1        0.46 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      0.60            +0.1        0.71        perf-profile.self.cycles-pp.ss_wakeup
      0.66            +0.1        0.78        perf-profile.self.cycles-pp.__get_user_8
      0.76 ±  2%      +0.1        0.90        perf-profile.self.cycles-pp.__libc_msgrcv
      0.39            +0.1        0.53        perf-profile.self.cycles-pp.load_msg
      0.76            +0.2        0.91        perf-profile.self.cycles-pp.__libc_msgsnd
      0.40 ±  3%      +0.2        0.56 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.95            +0.2        1.11        perf-profile.self.cycles-pp.mod_objcg_state
      1.10            +0.2        1.33        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.78            +0.2        1.03 ±  2%  perf-profile.self.cycles-pp.wake_up_q
      0.79            +0.2        1.04        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.40            +0.3        1.66        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.83            +0.3        1.09        perf-profile.self.cycles-pp.__check_object_size
      2.30 ±  2%      +0.4        2.69        perf-profile.self.cycles-pp._raw_spin_lock
      1.72            +0.4        2.12        perf-profile.self.cycles-pp.__list_del_entry_valid
      1.87            +0.4        2.30        perf-profile.self.cycles-pp.stress_msg
      5.16            +0.5        5.62        perf-profile.self.cycles-pp.percpu_counter_add_batch
      2.54            +0.5        3.05        perf-profile.self.cycles-pp.__kmem_cache_free
      2.64            +0.5        3.16        perf-profile.self.cycles-pp._copy_to_user
      2.75            +0.7        3.43        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      2.82            +0.7        3.53        perf-profile.self.cycles-pp.check_heap_object
      3.50            +0.9        4.41        perf-profile.self.cycles-pp.do_msgrcv
      4.16            +1.1        5.27        perf-profile.self.cycles-pp.__slab_free
      9.62            +1.4       11.07        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      6.51            +2.1        8.62        perf-profile.self.cycles-pp.ipc_obtain_object_check
      3.12            +2.1        5.26        perf-profile.self.cycles-pp.do_msgsnd



***************************************************************************************************
lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pts/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/msg/stress-ng/60s

commit: 
  bb0b988911 ("iomap: complete polled writes inline")
  f9f8b03900 ("fs: add IOCB flags related to passing back dio completions")

bb0b98891149e2f9 f9f8b03900fcd09aa9906ce7262 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      8499           -12.3%       7457        uptime.idle
 4.547e+09 ±  3%     -23.1%  3.498e+09        cpuidle..time
  24992050           +21.5%   30368614        cpuidle..usage
     21294 ±  6%     -44.6%      11794 ± 45%  numa-vmstat.node0.nr_slab_reclaimable
      9774 ± 15%     +98.1%      19359 ± 27%  numa-vmstat.node1.nr_slab_reclaimable
    884668 ±  2%     +19.2%    1054617 ±  4%  meminfo.Inactive
    884488 ±  2%     +19.2%    1054437 ±  4%  meminfo.Inactive(anon)
    497358 ±  3%     +33.0%     661416 ±  6%  meminfo.Mapped
   1245161           +15.3%    1435204        meminfo.Shmem
     54.75           -12.1       42.68        mpstat.cpu.all.idle%
      0.06 ±  3%      +0.0        0.07        mpstat.cpu.all.soft%
     42.21 ±  2%     +10.9       53.16        mpstat.cpu.all.sys%
      2.04 ±  3%      +1.1        3.11        mpstat.cpu.all.usr%
     85181 ±  6%     -44.6%      47178 ± 45%  numa-meminfo.node0.KReclaimable
     85181 ±  6%     -44.6%      47178 ± 45%  numa-meminfo.node0.SReclaimable
     39098 ± 15%     +98.1%      77437 ± 27%  numa-meminfo.node1.KReclaimable
     39098 ± 15%     +98.1%      77437 ± 27%  numa-meminfo.node1.SReclaimable
     55.50           -20.7%      44.00        vmstat.cpu.id
     56.00 ±  3%     +23.8%      69.33 ±  4%  vmstat.procs.r
    662751           +41.1%     935052 ±  2%  vmstat.system.cs
    197177           +17.5%     231594        vmstat.system.in
 1.459e+09           +52.7%  2.229e+09        stress-ng.msg.ops
  25016687 ±  8%     +47.3%   36839490        stress-ng.msg.ops_per_sec
      5750           +24.4%       7154        stress-ng.time.percent_of_cpu_this_job_got
      3470           +23.1%       4271        stress-ng.time.system_time
    133.62 ±  2%     +58.6%     211.93        stress-ng.time.user_time
  22509056           +38.6%   31198026 ±  2%  stress-ng.time.voluntary_context_switches
      1.38 ±  3%     -15.3%       1.17 ±  2%  perf-sched.total_wait_and_delay.average.ms
   1618878           +17.9%    1908967        perf-sched.total_wait_and_delay.count.ms
      1.38 ±  3%     -15.3%       1.17 ±  2%  perf-sched.total_wait_time.average.ms
    652193 ±  3%     +22.7%     800265 ±  3%  perf-sched.wait_and_delay.count.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    283.67 ±  5%     -33.5%     188.67 ± 12%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
    206596 ± 12%     +41.8%     293038        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
     21.83 ± 23%     -43.5%      12.33 ± 30%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     21.82 ± 23%     -43.5%      12.32 ± 30%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    109777            +3.4%     113474        proc-vmstat.nr_anon_pages
    988292            +4.8%    1035808        proc-vmstat.nr_file_pages
    221120 ±  2%     +19.2%     263608 ±  4%  proc-vmstat.nr_inactive_anon
    124314 ±  3%     +32.9%     165269 ±  6%  proc-vmstat.nr_mapped
    311304           +15.3%     358820        proc-vmstat.nr_shmem
    221120 ±  2%     +19.2%     263608 ±  4%  proc-vmstat.nr_zone_inactive_anon
   1396255            +7.5%    1501599 ±  2%  proc-vmstat.numa_hit
   1263645            +8.3%    1369016 ±  2%  proc-vmstat.numa_local
    344678 ±  3%     +10.9%     382305        proc-vmstat.pgactivate
   1470584            +6.7%    1569169 ±  2%  proc-vmstat.pgalloc_normal
    580921            -3.4%     560896        proc-vmstat.unevictable_pgs_scanned
      1531 ±  2%     +26.1%       1931        turbostat.Avg_MHz
     46.52 ±  2%     +12.1       58.62        turbostat.Busy%
    209017 ±  7%     +99.8%     417697 ± 11%  turbostat.C1
      0.15 ±  6%      +0.1        0.28 ± 13%  turbostat.C1%
  24000188           +22.1%   29293691        turbostat.C1E
     46.37           -10.8       35.56        turbostat.C1E%
     46.41           -23.4%      35.53        turbostat.CPU%c1
      0.13           +15.4%       0.15        turbostat.IPC
  13117864           +15.9%   15201206        turbostat.IRQ
     37605 ±  8%     +48.9%      56005 ± 14%  turbostat.POLL
     68.00 ±  2%      +4.7%      71.17        turbostat.PkgTmp
    400.72           +12.8%     451.98        turbostat.PkgWatt
    992260           +62.5%    1612232        sched_debug.cfs_rq:/.min_vruntime.avg
   1188178 ±  5%     +59.9%    1899986 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
    949468           +59.2%    1511969        sched_debug.cfs_rq:/.min_vruntime.min
    413.51           +28.5%     531.33 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
      1309 ±  9%     +20.7%       1580 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
     67.25 ± 28%     +44.7%      97.33 ± 17%  sched_debug.cfs_rq:/.runnable_avg.min
    269.12 ±  5%     +24.6%     335.26 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
    408.74           +29.1%     527.76 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      1297 ±  9%     +21.3%       1573 ±  6%  sched_debug.cfs_rq:/.util_avg.max
     67.75 ± 28%     +43.4%      97.17 ± 17%  sched_debug.cfs_rq:/.util_avg.min
    266.83 ±  5%     +24.9%     333.37 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     78.41 ± 11%     +51.9%     119.12 ± 12%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    140.42 ±  3%     +22.3%     171.66 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    166247           +38.4%     230168 ±  2%  sched_debug.cpu.nr_switches.avg
    203724 ±  4%     +30.5%     265846 ±  4%  sched_debug.cpu.nr_switches.max
      7275 ±  7%     +65.4%      12033 ±  7%  sched_debug.cpu.nr_switches.stddev
    155.63 ± 24%     +70.0%     264.56 ± 47%  sched_debug.cpu.nr_uninterruptible.stddev
 1.458e+10           +49.6%  2.181e+10        perf-stat.i.branch-instructions
  62931364           +65.2%  1.039e+08 ±  2%  perf-stat.i.branch-misses
     17.80 ±  5%      +3.2       21.04        perf-stat.i.cache-miss-rate%
 1.503e+08 ±  4%     +84.1%  2.768e+08        perf-stat.i.cache-misses
  8.23e+08           +57.1%  1.293e+09        perf-stat.i.cache-references
    701117           +40.5%     985412 ±  2%  perf-stat.i.context-switches
      2.63 ±  2%     -17.4%       2.17        perf-stat.i.cpi
 1.999e+11 ±  2%     +26.0%  2.519e+11        perf-stat.i.cpu-cycles
    120877 ±  8%     +73.4%     209542        perf-stat.i.cpu-migrations
      1568 ± 14%     -37.9%     973.99 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.07 ± 42%      -0.0        0.05 ±  4%  perf-stat.i.dTLB-load-miss-rate%
   9105590 ±  3%     +27.7%   11630778 ±  4%  perf-stat.i.dTLB-load-misses
 1.896e+10           +49.9%  2.842e+10        perf-stat.i.dTLB-loads
    689657 ±  7%     +46.5%    1010615        perf-stat.i.dTLB-store-misses
 1.112e+10           +52.7%  1.698e+10        perf-stat.i.dTLB-stores
 7.595e+10           +50.1%   1.14e+11        perf-stat.i.instructions
      0.40           +18.5%       0.47        perf-stat.i.ipc
      1.56 ±  2%     +26.0%       1.97        perf-stat.i.metric.GHz
    786.46 ±  3%     +69.1%       1330        perf-stat.i.metric.K/sec
    355.31           +50.6%     535.23        perf-stat.i.metric.M/sec
  61020291 ±  5%     +86.9%   1.14e+08        perf-stat.i.node-load-misses
    663004 ±  5%     +45.4%     964000 ±  9%  perf-stat.i.node-loads
     60.03 ±  2%      +3.3       63.32        perf-stat.i.node-store-miss-rate%
  21249401 ±  6%     +87.9%   39928222        perf-stat.i.node-store-misses
  13199431 ±  2%     +66.5%   21974199        perf-stat.i.node-stores
     10.85            +4.7%      11.35        perf-stat.overall.MPKI
      0.43 ±  2%      +0.0        0.48 ±  2%  perf-stat.overall.branch-miss-rate%
     18.23 ±  4%      +3.1       21.38        perf-stat.overall.cache-miss-rate%
      2.63           -16.0%       2.21        perf-stat.overall.cpi
      1332 ±  2%     -31.7%     910.31        perf-stat.overall.cycles-between-cache-misses
      0.05 ±  3%      -0.0        0.04 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.38           +19.1%       0.45        perf-stat.overall.ipc
     61.62            +2.9       64.49        perf-stat.overall.node-store-miss-rate%
 1.435e+10           +49.6%  2.147e+10        perf-stat.ps.branch-instructions
  61954258           +65.6%  1.026e+08 ±  2%  perf-stat.ps.branch-misses
 1.479e+08 ±  4%     +84.2%  2.724e+08        perf-stat.ps.cache-misses
 8.107e+08           +57.1%  1.274e+09        perf-stat.ps.cache-references
    690017           +40.5%     969557 ±  2%  perf-stat.ps.context-switches
 1.968e+11 ±  2%     +26.0%  2.479e+11        perf-stat.ps.cpu-cycles
    119024 ±  8%     +73.3%     206214        perf-stat.ps.cpu-migrations
   8926592 ±  3%     +28.9%   11507684 ±  4%  perf-stat.ps.dTLB-load-misses
 1.866e+10           +50.0%  2.798e+10        perf-stat.ps.dTLB-loads
    678508 ±  7%     +46.7%     995424        perf-stat.ps.dTLB-store-misses
 1.094e+10           +52.7%  1.671e+10        perf-stat.ps.dTLB-stores
 7.475e+10           +50.1%  1.122e+11        perf-stat.ps.instructions
      8913 ±  2%      +5.7%       9417 ±  3%  perf-stat.ps.minor-faults
  60014101 ±  5%     +86.9%  1.122e+08        perf-stat.ps.node-load-misses
    652178 ±  5%     +45.7%     950054 ±  9%  perf-stat.ps.node-loads
  20895606 ±  6%     +88.0%   39282378        perf-stat.ps.node-store-misses
  12986939 ±  2%     +66.5%   21628906        perf-stat.ps.node-stores
      8913 ±  2%      +5.7%       9417 ±  3%  perf-stat.ps.page-faults
 4.795e+12           +48.5%  7.119e+12        perf-stat.total.instructions
     12.70            -8.0        4.66        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.33            -7.8        4.55        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.37            -7.2        8.22        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     15.23            -6.8        8.43        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     13.46 ±  2%      -4.7        8.75        perf-profile.calltrace.cycles-pp.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
     13.52 ±  2%      -4.7        8.82        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
     13.54 ±  2%      -4.7        8.84        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msgctl
     13.63 ±  2%      -4.7        8.94        perf-profile.calltrace.cycles-pp.msgctl
      9.05            -2.4        6.60        perf-profile.calltrace.cycles-pp.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      4.12 ±  3%      -2.2        1.90 ±  2%  perf-profile.calltrace.cycles-pp.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      3.20 ±  3%      -2.0        1.16 ±  3%  perf-profile.calltrace.cycles-pp.down_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.10 ±  3%      -2.0        1.13 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl.do_syscall_64
      2.93 ±  2%      -2.0        0.97 ±  3%  perf-profile.calltrace.cycles-pp.down_read.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.76 ±  2%      -1.8        0.93 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl.do_syscall_64
      2.68 ±  3%      -1.1        1.62        perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.69 ±  3%      -1.1        1.63        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.70 ±  3%      -1.1        1.64 ±  2%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.68 ±  3%      -1.1        1.62        perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      2.72 ±  3%      -1.1        1.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      2.71 ±  3%      -1.1        1.66        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.73 ±  3%      -1.0        1.68        perf-profile.calltrace.cycles-pp.read
      1.76 ±  5%      -1.0        0.75 ±  3%  perf-profile.calltrace.cycles-pp.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read.ksys_read
      1.71 ±  5%      -1.0        0.71 ±  3%  perf-profile.calltrace.cycles-pp.down_read.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read
      1.64 ±  5%      -0.9        0.69 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.sysvipc_proc_start.seq_read_iter.seq_read
      4.74 ±  2%      -0.6        4.18        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl
      4.83 ±  2%      -0.5        4.30        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64
      2.26            -0.3        1.96        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.47            -0.3        2.17        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.22            -0.3        1.94        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.76            -0.2        0.56        perf-profile.calltrace.cycles-pp.up_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.43            -0.2        3.27        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.47            -0.2        3.30        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      3.44            -0.2        3.28        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.44            -0.2        3.28        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      1.76            -0.2        1.60        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.70            -0.1        0.55        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.msgctl_down.ksys_msgctl.do_syscall_64
      0.70            -0.1        0.64 ±  9%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      0.70            -0.1        0.64 ±  9%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl
      0.54            +0.1        0.61        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.57            +0.1        0.70 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      0.71            +0.2        0.87        perf-profile.calltrace.cycles-pp.__check_object_size.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.35 ± 70%      +0.2        0.58 ±  5%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      0.94 ±  2%      +0.2        1.17 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_user.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ± 70%      +0.2        0.57        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.66 ±  4%      +0.2        0.90 ±  9%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.do_msgrcv
      0.67 ±  4%      +0.2        0.91 ±  9%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_msgrcv.do_syscall_64
      0.46 ± 44%      +0.3        0.74 ± 10%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      1.25            +0.3        1.53        perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgsnd.stress_run
      0.46 ± 44%      +0.3        0.75 ±  9%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.93 ±  2%      +0.3        1.26 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ± 70%      +0.3        0.68 ±  9%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      0.93 ±  3%      +0.3        1.27 ±  6%  perf-profile.calltrace.cycles-pp.schedule.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.62 ±  4%      +0.4        1.00 ± 28%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      1.24            +0.4        1.63        perf-profile.calltrace.cycles-pp.stress_msg.stress_run
      1.24            +0.4        1.69        perf-profile.calltrace.cycles-pp.__list_del_entry_valid.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.sysvipc_msg_proc_show.seq_read_iter.seq_read.vfs_read.ksys_read
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.wake_up_q.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.__put_user_8.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.mod_objcg_state.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64
      0.00            +0.6        0.58 ±  3%  perf-profile.calltrace.cycles-pp.__get_user_8.__x64_sys_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.ss_wakeup.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.74 ± 26%      +0.7        1.41        perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgrcv.stress_run
      2.62 ±  2%      +0.8        3.38        perf-profile.calltrace.cycles-pp.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.04            +0.8        2.83        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.store_msg.do_msg_fill.do_msgrcv
      1.94            +0.8        2.73 ± 20%  perf-profile.calltrace.cycles-pp._copy_to_user.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      2.30            +0.8        3.12        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      3.38            +0.9        4.30        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      2.73            +1.0        3.73        perf-profile.calltrace.cycles-pp.__check_object_size.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      2.09            +1.1        3.22 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.12            +1.2        4.36        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      4.11            +1.2        5.36        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg.do_msgsnd
      2.74            +1.3        4.02 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      4.37            +1.3        5.68        perf-profile.calltrace.cycles-pp.__kmalloc.alloc_msg.load_msg.do_msgsnd.do_syscall_64
      3.00            +1.3        4.33        perf-profile.calltrace.cycles-pp.__slab_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.60            +1.4        5.99        perf-profile.calltrace.cycles-pp.alloc_msg.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.65            +1.7       40.38        perf-profile.calltrace.cycles-pp.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      6.46            +1.8        8.26        perf-profile.calltrace.cycles-pp.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     39.34            +1.9       41.23        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      5.03            +1.9        6.96 ±  7%  perf-profile.calltrace.cycles-pp.store_msg.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
     39.60            +2.0       41.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      5.68            +2.1        7.74 ±  6%  perf-profile.calltrace.cycles-pp.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     32.69            +2.2       34.93        perf-profile.calltrace.cycles-pp.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      6.19            +2.2        8.43        perf-profile.calltrace.cycles-pp.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     33.91            +2.5       36.45        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
     40.71            +2.7       43.41        perf-profile.calltrace.cycles-pp.__libc_msgrcv.stress_run
     34.32            +2.7       37.05        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      4.03            +2.8        6.80        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.69            +3.1        7.75        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     35.60            +3.7       39.30        perf-profile.calltrace.cycles-pp.__libc_msgsnd.stress_run
     78.53            +5.9       84.45        perf-profile.calltrace.cycles-pp.stress_run
     25.23           -15.9        9.31        perf-profile.children.cycles-pp.idr_find
     30.78           -14.0       16.78        perf-profile.children.cycles-pp.ipc_obtain_object_check
     13.46 ±  2%      -4.7        8.75        perf-profile.children.cycles-pp.ksys_msgctl
     13.65 ±  2%      -4.7        8.97        perf-profile.children.cycles-pp.msgctl
      4.20 ±  3%      -3.5        0.70        perf-profile.children.cycles-pp._raw_spin_lock_irq
      4.64 ±  3%      -3.0        1.68 ±  3%  perf-profile.children.cycles-pp.down_read
      4.40 ±  3%      -2.8        1.63 ±  3%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      9.05            -2.4        6.60        perf-profile.children.cycles-pp.msgctl_info
      4.12 ±  3%      -2.2        1.90 ±  2%  perf-profile.children.cycles-pp.msgctl_down
      3.20 ±  3%      -2.0        1.16 ±  3%  perf-profile.children.cycles-pp.down_write
      3.10 ±  3%      -2.0        1.13 ±  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     89.71            -1.3       88.42        perf-profile.children.cycles-pp.do_syscall_64
     90.27            -1.1       89.19        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.70 ±  3%      -1.1        1.63        perf-profile.children.cycles-pp.vfs_read
      2.68 ±  3%      -1.1        1.62        perf-profile.children.cycles-pp.seq_read_iter
      2.68 ±  3%      -1.1        1.62        perf-profile.children.cycles-pp.seq_read
      2.70 ±  3%      -1.1        1.64        perf-profile.children.cycles-pp.ksys_read
      2.73 ±  3%      -1.0        1.69        perf-profile.children.cycles-pp.read
      1.76 ±  5%      -1.0        0.75 ±  3%  perf-profile.children.cycles-pp.sysvipc_proc_start
      1.23 ±  7%      -1.0        0.26 ±  7%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      5.36 ±  2%      -0.9        4.45        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.92 ±  9%      -0.8        0.13 ± 14%  perf-profile.children.cycles-pp.osq_lock
      0.44 ±  2%      -0.3        0.10 ±  5%  perf-profile.children.cycles-pp.up_read
      0.92            -0.3        0.61        perf-profile.children.cycles-pp.rwsem_wake
      2.28            -0.3        1.98        perf-profile.children.cycles-pp.cpuidle_enter
      2.49            -0.3        2.20        perf-profile.children.cycles-pp.cpuidle_idle_call
      2.26            -0.3        1.97        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.76            -0.2        0.56        perf-profile.children.cycles-pp.up_write
      0.38 ±  2%      -0.2        0.21 ±  2%  perf-profile.children.cycles-pp.idr_get_next_ul
      0.39 ±  2%      -0.2        0.21 ±  2%  perf-profile.children.cycles-pp.idr_get_next
      3.47            -0.2        3.30        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      3.47            -0.2        3.30        perf-profile.children.cycles-pp.cpu_startup_entry
      3.44            -0.2        3.28        perf-profile.children.cycles-pp.start_secondary
      3.46            -0.2        3.30        perf-profile.children.cycles-pp.do_idle
      1.77            -0.2        1.62        perf-profile.children.cycles-pp.intel_idle
      0.43 ±  2%      -0.1        0.28        perf-profile.children.cycles-pp.sysvipc_proc_next
      0.21 ±  4%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.85 ±  2%      -0.1        0.76 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.80            -0.1        0.72 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.23            -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.msgctl_stat
      0.62 ±  2%      -0.0        0.58 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.62 ±  2%      -0.0        0.58 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.20 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.20 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.14            -0.0        0.11        perf-profile.children.cycles-pp.rwsem_mark_wake
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.07 ±  7%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.12 ±  4%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      0.07 ±  5%      +0.0        0.08        perf-profile.children.cycles-pp.__x64_sys_msgrcv
      0.06 ±  6%      +0.0        0.07        perf-profile.children.cycles-pp.ktime_get_real_seconds
      0.09 ±  4%      +0.0        0.10        perf-profile.children.cycles-pp.llist_add_batch
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.06 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.msgrcv@plt
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.prepare_task_switch
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      0.11 ±  3%      +0.0        0.13        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.07 ± 10%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.07 ±  5%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.security_msg_queue_msgsnd
      0.16 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.10 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp._find_next_or_bit
      0.11 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.09 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.security_msg_queue_msgrcv
      0.12 ±  4%      +0.0        0.15        perf-profile.children.cycles-pp.__cond_resched
      0.11 ±  6%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.security_msg_msg_alloc
      0.12 ±  4%      +0.0        0.14        perf-profile.children.cycles-pp.kmalloc_slab
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.format_decode
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.check_stack_object
      0.12 ±  4%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.finish_task_switch
      0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.available_idle_cpu
      0.17 ±  4%      +0.0        0.20 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.15 ±  3%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.18 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.security_ipc_permission
      0.14 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.number
      0.25 ±  2%      +0.0        0.29 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.13            +0.0        0.17        perf-profile.children.cycles-pp.select_idle_cpu
      0.15            +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
      0.31            +0.0        0.36        perf-profile.children.cycles-pp.enqueue_task_fair
      0.27            +0.0        0.31        perf-profile.children.cycles-pp.select_task_rq_fair
      0.34 ±  2%      +0.0        0.39 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.set_task_cpu
      0.28            +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.select_task_rq
      0.24            +0.1        0.30        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.30            +0.1        0.35        perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.20 ±  3%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      0.08            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.select_idle_core
      0.36            +0.1        0.42        perf-profile.children.cycles-pp.ttwu_do_activate
      0.34            +0.1        0.40        perf-profile.children.cycles-pp.dequeue_task_fair
      0.36            +0.1        0.42        perf-profile.children.cycles-pp.activate_task
      0.31 ±  2%      +0.1        0.37        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.24 ±  2%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.refill_obj_stock
      0.39            +0.1        0.46        perf-profile.children.cycles-pp.update_load_avg
      0.55            +0.1        0.62        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.38 ±  2%      +0.1        0.45        perf-profile.children.cycles-pp.__virt_addr_valid
      0.45            +0.1        0.53        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.53 ±  4%      +0.1        0.61 ±  5%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.54            +0.1        0.61 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.27 ±  2%      +0.1        0.35        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.33            +0.1        0.42        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.24 ±  2%      +0.1        0.34        perf-profile.children.cycles-pp.__list_add_valid
      0.40 ±  2%      +0.1        0.50        perf-profile.children.cycles-pp.vsnprintf
      0.40            +0.1        0.50        perf-profile.children.cycles-pp.seq_printf
      0.46 ±  2%      +0.1        0.56        perf-profile.children.cycles-pp.__check_heap_object
      0.52            +0.1        0.63        perf-profile.children.cycles-pp.__put_user_8
      0.42 ±  2%      +0.1        0.53        perf-profile.children.cycles-pp.sysvipc_msg_proc_show
      0.44 ±  2%      +0.1        0.55        perf-profile.children.cycles-pp.ipcperms
      0.38            +0.1        0.50 ±  7%  perf-profile.children.cycles-pp.kfree
      0.53 ±  2%      +0.1        0.66 ±  2%  perf-profile.children.cycles-pp.__get_user_8
      0.34 ±  2%      +0.1        0.47        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.81            +0.1        0.95 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      0.62            +0.1        0.76 ±  2%  perf-profile.children.cycles-pp.__x64_sys_msgsnd
      0.65            +0.2        0.80        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.77            +0.2        0.94        perf-profile.children.cycles-pp.mod_objcg_state
      0.46 ±  2%      +0.2        0.64        perf-profile.children.cycles-pp.ss_wakeup
      0.95            +0.2        1.19 ±  2%  perf-profile.children.cycles-pp._copy_from_user
      1.09            +0.3        1.35        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.42            +0.3        1.75        perf-profile.children.cycles-pp.__entry_text_start
      1.28            +0.4        1.65 ±  2%  perf-profile.children.cycles-pp.wake_up_q
      1.30            +0.4        1.70        perf-profile.children.cycles-pp.stress_msg
      1.31            +0.4        1.76        perf-profile.children.cycles-pp.__list_del_entry_valid
      2.66 ±  2%      +0.8        3.43        perf-profile.children.cycles-pp.__kmem_cache_free
      2.05            +0.8        2.87 ± 19%  perf-profile.children.cycles-pp._copy_to_user
      2.33            +0.8        3.15        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      2.51            +0.9        3.41        perf-profile.children.cycles-pp.check_heap_object
      4.20            +1.3        5.47        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      3.82            +1.3        5.14        perf-profile.children.cycles-pp.__check_object_size
      4.43            +1.3        5.75        perf-profile.children.cycles-pp.__kmalloc
      3.02            +1.3        4.35        perf-profile.children.cycles-pp.__slab_free
      4.63            +1.4        6.02        perf-profile.children.cycles-pp.alloc_msg
     38.87            +1.8       40.65        perf-profile.children.cycles-pp.do_msgrcv
      6.62            +1.9        8.50        perf-profile.children.cycles-pp.load_msg
      5.09            +1.9        7.03 ±  7%  perf-profile.children.cycles-pp.store_msg
      5.72            +2.1        7.80 ±  6%  perf-profile.children.cycles-pp.do_msg_fill
      6.56            +2.2        8.73        perf-profile.children.cycles-pp.percpu_counter_add_batch
      6.24            +2.3        8.50 ±  2%  perf-profile.children.cycles-pp.free_msg
     32.88            +2.3       35.15        perf-profile.children.cycles-pp.do_msgsnd
     41.14            +2.3       43.44        perf-profile.children.cycles-pp.__libc_msgrcv
     36.14            +3.2       39.38        perf-profile.children.cycles-pp.__libc_msgsnd
      7.95            +4.4       12.37        perf-profile.children.cycles-pp._raw_spin_lock
     78.53            +5.9       84.45        perf-profile.children.cycles-pp.stress_run
     25.08           -15.9        9.22        perf-profile.self.cycles-pp.idr_find
      0.91 ±  9%      -0.8        0.13 ± 14%  perf-profile.self.cycles-pp.osq_lock
      0.28            -0.2        0.06        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.24 ±  3%      -0.2        0.05        perf-profile.self.cycles-pp.down_read
      0.36 ±  3%      -0.2        0.19        perf-profile.self.cycles-pp.idr_get_next_ul
      0.34 ±  2%      -0.2        0.19 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.77            -0.2        1.62        perf-profile.self.cycles-pp.intel_idle
      0.34 ±  2%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.20 ±  3%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.12 ±  3%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.10            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.enqueue_task_fair
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.___perf_sw_event
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__switch_to
      0.06            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.security_msg_queue_msgsnd
      0.09 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      0.16 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.07 ±  6%      +0.0        0.09        perf-profile.self.cycles-pp.__x64_sys_msgsnd
      0.08 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.security_msg_queue_msgrcv
      0.11 ±  5%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.07 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.08            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp._find_next_or_bit
      0.11 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.alloc_msg
      0.10 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.kmalloc_slab
      0.11 ±  4%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.format_decode
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.check_stack_object
      0.10 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.security_msg_msg_alloc
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.available_idle_cpu
      0.10 ±  3%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.vsnprintf
      0.12 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.number
      0.12 ±  6%      +0.0        0.15 ±  6%  perf-profile.self.cycles-pp.update_cfs_group
      0.14            +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.__kmalloc
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.security_ipc_permission
      0.04 ± 44%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.msgctl_info
      0.16 ±  3%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.store_msg
      0.13            +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.do_msg_fill
      0.20 ±  2%      +0.0        0.24        perf-profile.self.cycles-pp.update_load_avg
      0.16 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.20            +0.0        0.25        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.msgctl
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__x64_sys_msgrcv
      0.22 ±  4%      +0.1        0.27 ±  6%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.19 ±  3%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      0.23 ±  3%      +0.1        0.29 ±  6%  perf-profile.self.cycles-pp.refill_obj_stock
      0.22 ±  2%      +0.1        0.29        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.22 ±  2%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.35 ±  2%      +0.1        0.42        perf-profile.self.cycles-pp.__virt_addr_valid
      0.30            +0.1        0.38        perf-profile.self.cycles-pp.do_syscall_64
      0.33 ±  2%      +0.1        0.42        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.22 ±  3%      +0.1        0.31 ±  2%  perf-profile.self.cycles-pp.__list_add_valid
      0.40            +0.1        0.49        perf-profile.self.cycles-pp.__entry_text_start
      0.28 ±  4%      +0.1        0.38 ±  2%  perf-profile.self.cycles-pp.load_msg
      0.43 ±  2%      +0.1        0.53        perf-profile.self.cycles-pp.__check_heap_object
      0.50 ±  2%      +0.1        0.61        perf-profile.self.cycles-pp.__put_user_8
      0.41 ±  2%      +0.1        0.52        perf-profile.self.cycles-pp.ipcperms
      0.32 ±  2%      +0.1        0.44 ±  6%  perf-profile.self.cycles-pp.kfree
      0.08 ±  4%      +0.1        0.20 ± 14%  perf-profile.self.cycles-pp.try_to_wake_up
      0.50 ±  2%      +0.1        0.62 ±  2%  perf-profile.self.cycles-pp.__get_user_8
      0.58 ±  2%      +0.1        0.71        perf-profile.self.cycles-pp.__libc_msgrcv
      0.34 ±  2%      +0.1        0.47        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.58            +0.1        0.72 ±  3%  perf-profile.self.cycles-pp.__libc_msgsnd
      0.72            +0.2        0.88        perf-profile.self.cycles-pp.mod_objcg_state
      0.44 ±  2%      +0.2        0.61        perf-profile.self.cycles-pp.ss_wakeup
      0.44            +0.2        0.66        perf-profile.self.cycles-pp.wake_up_q
      0.92 ±  2%      +0.2        1.14 ±  2%  perf-profile.self.cycles-pp._copy_from_user
      0.79            +0.2        1.02        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.58            +0.2        0.80        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.06            +0.2        1.31        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.69            +0.2        0.94        perf-profile.self.cycles-pp.__check_object_size
      0.75            +0.3        1.06        perf-profile.self.cycles-pp.__percpu_counter_sum
      1.25            +0.4        1.62        perf-profile.self.cycles-pp.stress_msg
      1.29            +0.4        1.73        perf-profile.self.cycles-pp.__list_del_entry_valid
      1.80            +0.5        2.30        perf-profile.self.cycles-pp._raw_spin_lock
      1.91 ±  2%      +0.6        2.50        perf-profile.self.cycles-pp.__kmem_cache_free
      2.03            +0.8        2.78        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      2.00            +0.8        2.80        perf-profile.self.cycles-pp.check_heap_object
      2.02            +0.8        2.82 ± 20%  perf-profile.self.cycles-pp._copy_to_user
      2.31            +0.8        3.15        perf-profile.self.cycles-pp.do_msgrcv
      2.99            +1.3        4.31        perf-profile.self.cycles-pp.__slab_free
      4.48            +1.8        6.31        perf-profile.self.cycles-pp.ipc_obtain_object_check
      6.44            +2.1        8.58        perf-profile.self.cycles-pp.percpu_counter_add_batch
      2.02            +2.8        4.84        perf-profile.self.cycles-pp.do_msgsnd



***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pts/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/msg/stress-ng/60s

commit: 
  bb0b988911 ("iomap: complete polled writes inline")
  f9f8b03900 ("fs: add IOCB flags related to passing back dio completions")

bb0b98891149e2f9 f9f8b03900fcd09aa9906ce7262 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     16885           -13.5%      14607 ±  3%  uptime.idle
  9.52e+09           -23.9%  7.249e+09 ±  5%  cpuidle..time
  26492692           +29.0%   34171037        cpuidle..usage
     27657 ±  6%     -12.0%      24342 ±  2%  numa-vmstat.node0.nr_slab_reclaimable
      3255 ± 30%     +46.3%       4763 ± 25%  numa-vmstat.node1.nr_page_table_pages
     11683 ± 15%     +30.1%      15200 ±  4%  numa-vmstat.node1.nr_slab_reclaimable
     66.75           -16.4       50.36 ±  2%  mpstat.cpu.all.idle%
      0.08            +0.0        0.09 ±  2%  mpstat.cpu.all.soft%
     31.18           +15.6       46.78 ±  2%  mpstat.cpu.all.sys%
      1.08            +0.7        1.78 ±  2%  mpstat.cpu.all.usr%
     67.33           -23.5%      51.50 ±  2%  vmstat.cpu.id
     68.83 ±  5%     +53.3%     105.50 ±  3%  vmstat.procs.r
    520720           +62.6%     846898 ±  2%  vmstat.system.cs
    293913           +17.6%     345783        vmstat.system.in
    174.00 ±  7%     +20.9%     210.33 ± 13%  perf-c2c.DRAM.local
     10092 ±  3%    +100.8%      20267 ±  7%  perf-c2c.DRAM.remote
     34343 ±  4%     +58.8%      54524 ±  7%  perf-c2c.HITM.local
      7196 ±  3%    +106.1%      14830 ±  8%  perf-c2c.HITM.remote
     41540 ±  4%     +67.0%      69354 ±  7%  perf-c2c.HITM.total
    386542 ±  3%     +31.2%     507276 ± 10%  meminfo.Active
    386414 ±  3%     +31.2%     507151 ± 10%  meminfo.Active(anon)
   1059908           +26.4%    1340157 ±  2%  meminfo.Inactive
   1059740           +26.4%    1339986 ±  2%  meminfo.Inactive(anon)
   1040308 ±  2%     +30.6%    1358214 ±  2%  meminfo.Mapped
   1033797           +37.0%    1416210 ±  2%  meminfo.Shmem
    110632 ±  6%     -12.0%      97371 ±  2%  numa-meminfo.node0.KReclaimable
    110632 ±  6%     -12.0%      97371 ±  2%  numa-meminfo.node0.SReclaimable
    355692 ±  5%     -10.1%     319828 ±  3%  numa-meminfo.node0.Slab
     46733 ± 15%     +30.1%      60803 ±  4%  numa-meminfo.node1.KReclaimable
   2399630 ± 14%     +28.0%    3070625 ±  7%  numa-meminfo.node1.MemUsed
     13022 ± 30%     +46.4%      19059 ± 25%  numa-meminfo.node1.PageTables
     46733 ± 15%     +30.1%      60803 ±  4%  numa-meminfo.node1.SReclaimable
    241031 ±  8%     +15.7%     278930 ±  3%  numa-meminfo.node1.Slab
 1.135e+09           +82.3%  2.068e+09        stress-ng.msg.ops
  19362928 ±  7%     +77.0%   34270169        stress-ng.msg.ops_per_sec
     10627 ±  4%     +96.9%      20929 ±  6%  stress-ng.time.involuntary_context_switches
     38573            +9.1%      42079 ±  3%  stress-ng.time.minor_page_faults
      7324           +49.6%      10954        stress-ng.time.percent_of_cpu_this_job_got
      4492           +48.7%       6678        stress-ng.time.system_time
    100.66           +88.4%     189.60        stress-ng.time.user_time
  17125455           +64.7%   28202557        stress-ng.time.voluntary_context_switches
    984.67           +47.8%       1455 ±  2%  turbostat.Avg_MHz
     34.05           +16.2       50.30 ±  2%  turbostat.Busy%
    138943 ±  3%     +15.7%     160810        turbostat.C1
  25681244           +29.6%   33288295        turbostat.C1E
     62.28           -16.7       45.59        turbostat.C1E%
     65.95           -24.6%      49.70 ±  2%  turbostat.CPU%c1
      0.17           +19.6%       0.20 ±  2%  turbostat.IPC
  19221628           +18.9%   22850173 ±  2%  turbostat.IRQ
     35759           +24.6%      44559 ±  2%  turbostat.POLL
    467.97           +13.9%     532.88        turbostat.PkgWatt
     20.39           +15.8%      23.61        turbostat.RAMWatt
     96614 ±  3%     +31.3%     126811 ± 10%  proc-vmstat.nr_active_anon
    103279            +4.5%     107931        proc-vmstat.nr_anon_pages
    944259           +10.1%    1039902        proc-vmstat.nr_file_pages
    264956           +26.4%     335035 ±  2%  proc-vmstat.nr_inactive_anon
    260164 ±  2%     +30.6%     339696 ±  2%  proc-vmstat.nr_mapped
    258468           +37.0%     354103 ±  2%  proc-vmstat.nr_shmem
     96614 ±  3%     +31.3%     126811 ± 10%  proc-vmstat.nr_zone_active_anon
    264956           +26.4%     335035 ±  2%  proc-vmstat.nr_zone_inactive_anon
    111239 ± 12%    +102.8%     225581 ± 15%  proc-vmstat.numa_hint_faults
     75597 ± 11%     +96.8%     148809 ± 13%  proc-vmstat.numa_hint_faults_local
   1480951            +2.9%    1524043        proc-vmstat.numa_hit
   1249147            +3.4%    1292180        proc-vmstat.numa_local
     28078 ± 22%     -49.5%      14165 ± 35%  proc-vmstat.numa_pages_migrated
    421360 ±  5%     +25.9%     530314 ±  6%  proc-vmstat.numa_pte_updates
    328371           +22.6%     402492        proc-vmstat.pgactivate
   1576330            +2.6%    1618065        proc-vmstat.pgalloc_normal
    963324           +13.9%    1097466 ±  2%  proc-vmstat.pgfault
   1229528            -9.3%    1115213        proc-vmstat.pgfree
     28078 ± 22%     -49.5%      14165 ± 35%  proc-vmstat.pgmigrate_success
     40760 ±  2%     -23.3%      31243 ±  4%  proc-vmstat.pgreuse
      0.01 ±  9%     -13.9%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
     26.80 ±  9%     +18.4%      31.74 ±  4%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      3.14 ±  3%     -25.6%       2.33        perf-sched.total_wait_and_delay.average.ms
   1276710           +36.6%    1744371        perf-sched.total_wait_and_delay.count.ms
      3.13 ±  3%     -25.7%       2.33        perf-sched.total_wait_time.average.ms
      1.30 ±  9%     -23.4%       1.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
      4.96 ±  9%     -22.2%       3.86 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    527789 ±  2%     +36.0%     717689        perf-sched.wait_and_delay.count.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    125.33 ±  4%     +14.5%     143.50 ±  4%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    389597 ±  2%     +35.6%     528417        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.msgctl_info.constprop
    157808 ±  9%     +70.6%     269195        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
    194106           +14.3%     221898        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
    852.50 ± 11%     +29.6%       1105 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1172 ± 31%     +70.6%       1999        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     40.49 ± 17%     +32.4%      53.60 ± 13%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.msgctl_info.constprop
     77.14 ± 45%     -62.9%      28.64 ± 25%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.27 ± 19%     -32.4%       0.86 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      1.30 ±  9%     -23.4%       0.99        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
      4.95 ±  9%     -22.3%       3.85 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1172 ± 31%     +70.6%       1999        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     77.13 ± 45%     -64.0%      27.80 ± 29%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.21 ±  6%     +51.1%       0.32 ±  4%  sched_debug.cfs_rq:/.h_nr_running.avg
    809774          +154.2%    2058344        sched_debug.cfs_rq:/.min_vruntime.avg
   1372021 ± 14%     +93.7%    2658246 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
    675815          +128.2%    1542329 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
     44680 ± 18%     +34.8%      60232 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.21 ±  6%     +50.8%       0.32 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
    256.29 ±  5%     +62.4%     416.32 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
      1083 ± 16%     +66.6%       1805 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
    196.71 ±  7%     +55.1%     305.15 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
   -130552          +292.3%    -512115        sched_debug.cfs_rq:/.spread0.min
     44655 ± 18%     +34.9%      60234 ± 12%  sched_debug.cfs_rq:/.spread0.stddev
    255.17 ±  5%     +62.8%     415.38 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
      1058 ± 16%     +69.4%       1792 ±  9%  sched_debug.cfs_rq:/.util_avg.max
    195.52 ±  7%     +55.6%     304.21 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
     42.12 ±  7%    +151.2%     105.80 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    419.33 ±  3%     +28.0%     536.58 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.max
     88.90 ±  7%     +51.3%     134.54        sched_debug.cfs_rq:/.util_est_enqueued.stddev
    722904           -21.2%     569884        sched_debug.cpu.avg_idle.avg
    182865 ±  3%     -28.1%     131466 ±  8%  sched_debug.cpu.avg_idle.stddev
      1597 ±  5%     +58.1%       2525 ±  3%  sched_debug.cpu.curr->pid.avg
      0.21 ±  5%     +54.1%       0.32 ±  2%  sched_debug.cpu.nr_running.avg
     73902           +63.2%     120588        sched_debug.cpu.nr_switches.avg
    122295 ± 14%     +39.9%     171030 ±  3%  sched_debug.cpu.nr_switches.max
     41419 ± 22%     +51.3%      62649 ± 11%  sched_debug.cpu.nr_switches.min
      5728 ± 13%     +46.1%       8369 ±  3%  sched_debug.cpu.nr_switches.stddev
      0.39 ±  2%     -19.2%       0.31 ±  3%  sched_debug.cpu.nr_uninterruptible.avg
     48.92 ±  3%     +39.7%      68.33 ± 15%  sched_debug.cpu.nr_uninterruptible.max
    -57.00          +249.6%    -199.25        sched_debug.cpu.nr_uninterruptible.min
      9.48 ±  6%    +136.5%      22.42 ± 15%  sched_debug.cpu.nr_uninterruptible.stddev
      7.22           +14.4%       8.26        perf-stat.i.MPKI
 1.242e+10           +79.0%  2.223e+10 ±  2%  perf-stat.i.branch-instructions
      0.41 ±  2%      +0.1        0.52        perf-stat.i.branch-miss-rate%
  45779364          +131.7%  1.061e+08 ±  2%  perf-stat.i.branch-misses
     16.50            +1.7       18.24        perf-stat.i.cache-miss-rate%
  73261648          +130.6%  1.689e+08 ±  2%  perf-stat.i.cache-misses
 4.644e+08          +108.5%  9.684e+08 ±  2%  perf-stat.i.cache-references
    545474           +62.0%     883853 ±  2%  perf-stat.i.context-switches
      3.40           -17.8%       2.79        perf-stat.i.cpi
 2.199e+11           +47.8%   3.25e+11 ±  2%  perf-stat.i.cpu-cycles
     58684 ±  8%    +204.3%     178600 ±  2%  perf-stat.i.cpu-migrations
      2968           -30.9%       2050 ± 17%  perf-stat.i.cycles-between-cache-misses
  10984557 ±  4%     +75.9%   19321763 ±  5%  perf-stat.i.dTLB-load-misses
 1.581e+10           +80.0%  2.846e+10 ±  2%  perf-stat.i.dTLB-loads
    417979 ±  5%     +97.7%     826401 ±  5%  perf-stat.i.dTLB-store-misses
 8.708e+09           +80.0%  1.567e+10 ±  2%  perf-stat.i.dTLB-stores
 6.349e+10           +79.5%   1.14e+11 ±  2%  perf-stat.i.instructions
      0.31           +20.5%       0.37        perf-stat.i.ipc
      0.98           +47.8%       1.45 ±  2%  perf-stat.i.metric.GHz
    198.27          +123.2%     442.59 ±  3%  perf-stat.i.metric.K/sec
    166.90           +80.0%     300.50 ±  2%  perf-stat.i.metric.M/sec
     14242           +17.1%      16682 ±  5%  perf-stat.i.minor-faults
  37796701          +140.1%   90756192 ±  2%  perf-stat.i.node-load-misses
    583090 ±  9%     +31.5%     766761 ±  6%  perf-stat.i.node-loads
     14242           +17.1%      16682 ±  5%  perf-stat.i.page-faults
      7.40           +17.5%       8.69        perf-stat.overall.MPKI
      0.37            +0.1        0.49        perf-stat.overall.branch-miss-rate%
     15.58            +1.4       17.00        perf-stat.overall.cache-miss-rate%
      3.46           -18.0%       2.84        perf-stat.overall.cpi
      3001           -36.0%       1920        perf-stat.overall.cycles-between-cache-misses
      0.00 ±  5%      +0.0        0.01 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
      0.29           +21.9%       0.35        perf-stat.overall.ipc
 1.229e+10           +80.1%  2.213e+10 ±  2%  perf-stat.ps.branch-instructions
  45590127          +137.9%  1.084e+08 ±  2%  perf-stat.ps.branch-misses
  72420816          +131.6%  1.678e+08 ±  2%  perf-stat.ps.cache-misses
 4.648e+08          +112.2%  9.865e+08 ±  2%  perf-stat.ps.cache-references
    538459           +62.4%     874198 ±  2%  perf-stat.ps.context-switches
 2.173e+11           +48.2%  3.221e+11 ±  2%  perf-stat.ps.cpu-cycles
     58152 ±  7%    +204.4%     177038 ±  2%  perf-stat.ps.cpu-migrations
  11415487 ±  4%     +78.4%   20366962 ±  5%  perf-stat.ps.dTLB-load-misses
 1.565e+10           +81.4%   2.84e+10 ±  2%  perf-stat.ps.dTLB-loads
    417989 ±  5%     +99.1%     832373 ±  5%  perf-stat.ps.dTLB-store-misses
 8.613e+09           +81.1%   1.56e+10 ±  2%  perf-stat.ps.dTLB-stores
 6.283e+10           +80.7%  1.135e+11 ±  2%  perf-stat.ps.instructions
     13730           +15.3%      15837 ±  5%  perf-stat.ps.minor-faults
  37360564          +141.3%   90166765 ±  2%  perf-stat.ps.node-load-misses
    591293 ± 11%     +30.2%     770060 ±  7%  perf-stat.ps.node-loads
     13730           +15.3%      15837 ±  5%  perf-stat.ps.page-faults
 4.011e+12           +82.3%  7.311e+12        perf-stat.total.instructions
     13.55           -12.2        1.31        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.16           -11.9        1.30        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.74           -11.7        4.04        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     15.25           -11.3        4.00        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      4.98 ±  2%      -3.7        1.26        perf-profile.calltrace.cycles-pp.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      4.00            -3.3        0.66        perf-profile.calltrace.cycles-pp.down_read.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.85            -3.2        0.62        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl.do_syscall_64
      3.86 ±  2%      -3.2        0.65        perf-profile.calltrace.cycles-pp.down_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.74 ±  2%      -3.1        0.62        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl.do_syscall_64
      3.64 ± 14%      -2.8        0.86 ±  2%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.63 ± 14%      -2.8        0.86 ±  2%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      3.64 ± 14%      -2.8        0.88 ±  2%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.64 ± 14%      -2.8        0.88 ±  2%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.66 ± 14%      -2.8        0.90 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.66 ± 14%      -2.8        0.90        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      3.67 ± 14%      -2.8        0.92 ±  2%  perf-profile.calltrace.cycles-pp.read
     33.22            -2.5       30.72        perf-profile.calltrace.cycles-pp.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
     33.70            -2.4       31.32        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
     33.87            -2.3       31.53        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
     34.62            -2.2       32.46        perf-profile.calltrace.cycles-pp.__libc_msgrcv.stress_run
     66.25            -2.0       64.28        perf-profile.calltrace.cycles-pp.stress_run
     28.08            -0.9       27.13        perf-profile.calltrace.cycles-pp.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
     28.88            -0.7       28.16        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      2.06            -0.6        1.46        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.90            -0.6        1.32        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.86            -0.6        1.29        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.69            -0.5        2.23        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      2.67            -0.5        2.21        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.67            -0.5        2.22        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.67            -0.5        2.22        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      1.20 ± 13%      -0.4        0.78 ±  9%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      1.19 ± 13%      -0.4        0.78 ±  9%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      1.04            -0.2        0.86        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.54            +0.1        0.64        perf-profile.calltrace.cycles-pp._copy_from_user.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.75 ±  2%      +0.2        0.96        perf-profile.calltrace.cycles-pp.stress_msg.stress_run
      1.10 ± 17%      +0.4        1.46        perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgsnd.stress_run
      1.03            +0.4        1.44        perf-profile.calltrace.cycles-pp.__list_del_entry_valid.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.ss_wakeup.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.__check_object_size.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.schedule.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.59            +0.7        1.24        perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgrcv.stress_run
      1.98            +0.7        2.64        perf-profile.calltrace.cycles-pp.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.04            +0.7        2.72        perf-profile.calltrace.cycles-pp._copy_to_user.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      1.71            +0.7        2.41        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      1.54            +0.7        2.26        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.store_msg.do_msg_fill.do_msgrcv
      1.92            +0.9        2.80        perf-profile.calltrace.cycles-pp.__check_object_size.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      2.97            +1.0        4.01        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg.do_msgsnd
      3.19            +1.1        4.32        perf-profile.calltrace.cycles-pp.__kmalloc.alloc_msg.load_msg.do_msgsnd.do_syscall_64
      3.35            +1.2        4.53        perf-profile.calltrace.cycles-pp.alloc_msg.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.24            +1.3        3.52        perf-profile.calltrace.cycles-pp.__slab_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.50            +1.5        5.96        perf-profile.calltrace.cycles-pp.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      3.22            +1.5        4.70        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      4.14            +1.6        5.76        perf-profile.calltrace.cycles-pp.store_msg.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.56            +1.7        6.30        perf-profile.calltrace.cycles-pp.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      3.10            +1.8        4.86        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      2.08            +2.1        4.16        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.44            +2.2        4.61        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      4.57            +2.2        6.78        perf-profile.calltrace.cycles-pp.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      3.10            +3.4        6.48        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.52            +3.6        7.08        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     25.81 ±  2%      +5.6       31.36        perf-profile.calltrace.cycles-pp.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
     25.87 ±  2%      +5.6       31.42        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
     25.88 ±  2%      +5.6       31.44        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msgctl
     25.94 ±  2%      +5.6       31.52        perf-profile.calltrace.cycles-pp.msgctl
     20.58 ±  2%      +9.4       29.94        perf-profile.calltrace.cycles-pp.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
     15.17 ±  4%     +12.3       27.48        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl
     15.26 ±  4%     +12.3       27.58        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64
     16.21 ±  3%     +12.9       29.10        perf-profile.calltrace.cycles-pp.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.91           -24.3        2.64        perf-profile.children.cycles-pp.idr_find
     31.15           -23.0        8.11        perf-profile.children.cycles-pp.ipc_obtain_object_check
      7.91 ±  5%      -7.5        0.45 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      6.82 ±  6%      -5.8        1.02        perf-profile.children.cycles-pp.down_read
      6.61 ±  7%      -5.6        0.96 ±  2%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      4.98 ±  2%      -3.7        1.26        perf-profile.children.cycles-pp.msgctl_down
      3.86 ±  2%      -3.2        0.65        perf-profile.children.cycles-pp.down_write
      3.75 ±  2%      -3.1        0.62        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      3.64 ± 14%      -2.8        0.86 ±  2%  perf-profile.children.cycles-pp.seq_read
      3.64 ± 14%      -2.8        0.86 ±  2%  perf-profile.children.cycles-pp.seq_read_iter
      3.64 ± 14%      -2.8        0.88 ±  2%  perf-profile.children.cycles-pp.vfs_read
      3.64 ± 14%      -2.8        0.88 ±  2%  perf-profile.children.cycles-pp.ksys_read
      3.67 ± 14%      -2.7        0.92 ±  2%  perf-profile.children.cycles-pp.read
      2.88 ± 16%      -2.5        0.38 ±  3%  perf-profile.children.cycles-pp.sysvipc_proc_start
     33.37            -2.5       30.91        perf-profile.children.cycles-pp.do_msgrcv
     35.08            -2.1       33.03        perf-profile.children.cycles-pp.__libc_msgrcv
     66.25            -2.0       64.28        perf-profile.children.cycles-pp.stress_run
      1.34 ±  7%      -1.2        0.15        perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.01 ±  9%      -0.9        0.06 ±  7%  perf-profile.children.cycles-pp.osq_lock
     28.20            -0.9       27.28        perf-profile.children.cycles-pp.do_msgsnd
      2.07            -0.6        1.47        perf-profile.children.cycles-pp.cpuidle_idle_call
      1.12 ±  2%      -0.6        0.52        perf-profile.children.cycles-pp.rwsem_wake
      1.91            -0.6        1.32        perf-profile.children.cycles-pp.cpuidle_enter
      1.91            -0.6        1.32        perf-profile.children.cycles-pp.cpuidle_enter_state
      1.00 ±  2%      -0.5        0.48        perf-profile.children.cycles-pp.up_write
      2.69            -0.5        2.23        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      2.69            -0.5        2.23        perf-profile.children.cycles-pp.cpu_startup_entry
      2.68            -0.5        2.22        perf-profile.children.cycles-pp.do_idle
      2.67            -0.5        2.22        perf-profile.children.cycles-pp.start_secondary
      1.28 ± 11%      -0.4        0.85 ±  9%  perf-profile.children.cycles-pp.record__finish_output
      1.28 ± 11%      -0.4        0.85 ±  9%  perf-profile.children.cycles-pp.perf_session__process_events
      1.28 ± 11%      -0.4        0.85 ±  9%  perf-profile.children.cycles-pp.reader__read_event
      1.21 ± 13%      -0.4        0.79 ± 10%  perf-profile.children.cycles-pp.process_simple
      1.20 ± 13%      -0.4        0.78 ±  9%  perf-profile.children.cycles-pp.ordered_events__queue
      1.20 ± 13%      -0.4        0.78 ±  9%  perf-profile.children.cycles-pp.queue_event
      0.89            -0.4        0.50 ±  3%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.44 ±  6%      -0.4        0.07 ±  5%  perf-profile.children.cycles-pp.idr_get_next
      0.44 ±  6%      -0.4        0.07 ±  5%  perf-profile.children.cycles-pp.idr_get_next_ul
      0.48 ±  6%      -0.3        0.16        perf-profile.children.cycles-pp.sysvipc_proc_next
      1.30            -0.3        1.01        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.36            -0.3        0.09        perf-profile.children.cycles-pp.up_read
      1.22            -0.3        0.96        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.04            -0.2        0.86        perf-profile.children.cycles-pp.intel_idle
      0.91            -0.2        0.75 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.88            -0.1        0.74 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.20 ±  2%      -0.1        0.06        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.81            -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.30            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.30            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.74            -0.1        0.64 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.21            -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.msgctl_stat
      0.70            -0.1        0.62 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.70            -0.1        0.62 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.24 ±  4%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.62            -0.1        0.56 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.22 ±  4%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.__do_softirq
      0.17 ±  2%      -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.14 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.rebalance_domains
      0.09 ±  4%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.ktime_get
      0.14 ±  2%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.10 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.08 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.task_mm_cid_work
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.task_work_run
      0.13            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.update_rq_clock
      0.13 ±  2%      +0.0        0.14        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.06 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.security_msg_queue_msgrcv
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.format_decode
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.security_msg_queue_msgsnd
      0.09 ±  5%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.update_curr
      0.08 ±  4%      +0.0        0.10        perf-profile.children.cycles-pp.kmalloc_slab
      0.08 ±  4%      +0.0        0.10        perf-profile.children.cycles-pp.number
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.wake_affine
      0.12 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.11 ±  3%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.security_ipc_permission
      0.12 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp._find_next_or_bit
      0.10 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.switch_fpu_return
      0.23 ±  2%      +0.0        0.27        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.22 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.schedule_idle
      0.09 ±  4%      +0.0        0.13        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.rcu_all_qs
      0.10            +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.check_stack_object
      0.16 ±  3%      +0.0        0.20        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.14 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.02 ±141%      +0.0        0.06        perf-profile.children.cycles-pp.__switch_to
      0.17 ±  4%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.15            +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ktime_get_real_seconds
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.16 ±  2%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.09 ±  7%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.__switch_to_asm
      0.22 ±  2%      +0.1        0.27        perf-profile.children.cycles-pp.__virt_addr_valid
      0.22 ±  3%      +0.1        0.27 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.20 ±  4%      +0.1        0.26        perf-profile.children.cycles-pp.seq_printf
      0.17 ±  2%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.20 ±  4%      +0.1        0.25        perf-profile.children.cycles-pp.vsnprintf
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp._find_next_and_bit
      0.17 ±  2%      +0.1        0.23        perf-profile.children.cycles-pp.dequeue_entity
      0.21 ±  5%      +0.1        0.28        perf-profile.children.cycles-pp.sysvipc_msg_proc_show
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.task_h_load
      0.16            +0.1        0.23        perf-profile.children.cycles-pp.refill_obj_stock
      0.18 ±  2%      +0.1        0.25        perf-profile.children.cycles-pp.dequeue_task_fair
      0.21            +0.1        0.29        perf-profile.children.cycles-pp.ttwu_do_activate
      0.20            +0.1        0.28        perf-profile.children.cycles-pp.activate_task
      0.06 ± 11%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.select_idle_core
      0.26            +0.1        0.35 ±  3%  perf-profile.children.cycles-pp.__check_heap_object
      0.37 ±  2%      +0.1        0.45        perf-profile.children.cycles-pp.__get_user_8
      0.06 ±  7%      +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.cpu_util
      0.06 ± 11%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.select_idle_cpu
      0.24 ±  3%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.27            +0.1        0.36        perf-profile.children.cycles-pp.ipcperms
      0.28            +0.1        0.37        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.06 ±  7%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.idle_cpu
      0.34 ±  3%      +0.1        0.44        perf-profile.children.cycles-pp.__put_user_8
      0.08 ± 10%      +0.1        0.17 ±  3%  perf-profile.children.cycles-pp.select_idle_sibling
      0.33            +0.1        0.42        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.44            +0.1        0.53        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.55            +0.1        0.65        perf-profile.children.cycles-pp._copy_from_user
      0.32            +0.1        0.42        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.17 ±  2%      +0.1        0.28        perf-profile.children.cycles-pp.kfree
      0.42 ±  2%      +0.1        0.53        perf-profile.children.cycles-pp.__x64_sys_msgsnd
      0.17 ±  5%      +0.1        0.28        perf-profile.children.cycles-pp.select_task_rq_fair
      0.18 ±  4%      +0.1        0.30        perf-profile.children.cycles-pp.select_task_rq
      0.53            +0.1        0.66        perf-profile.children.cycles-pp.mod_objcg_state
      0.53            +0.1        0.67        perf-profile.children.cycles-pp.try_to_wake_up
      0.19 ±  4%      +0.2        0.35 ±  2%  perf-profile.children.cycles-pp.security_msg_msg_free
      0.35            +0.2        0.52        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.66            +0.2        0.84        perf-profile.children.cycles-pp.wake_up_q
      0.37 ±  2%      +0.2        0.56        perf-profile.children.cycles-pp.ss_wakeup
      0.73 ±  2%      +0.2        0.93        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.78 ±  2%      +0.2        0.99        perf-profile.children.cycles-pp.stress_msg
      0.49 ±  5%      +0.3        0.77 ±  2%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      1.30            +0.3        1.60        perf-profile.children.cycles-pp.__entry_text_start
      1.08            +0.4        1.48        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.35 ±  8%      +0.5        0.81 ±  3%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.36 ±  8%      +0.5        0.84 ±  3%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.36 ±  7%      +0.5        0.85 ±  2%  perf-profile.children.cycles-pp.find_busiest_group
      0.39 ±  7%      +0.5        0.90 ±  3%  perf-profile.children.cycles-pp.load_balance
      0.37 ±  9%      +0.5        0.91 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      0.40 ±  7%      +0.5        0.94 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.79 ±  3%      +0.6        1.42 ±  2%  perf-profile.children.cycles-pp.schedule
      1.00 ±  2%      +0.7        1.66        perf-profile.children.cycles-pp.__schedule
      2.00            +0.7        2.68        perf-profile.children.cycles-pp.__kmem_cache_free
      2.11            +0.7        2.80        perf-profile.children.cycles-pp._copy_to_user
      1.73            +0.7        2.43        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      1.88            +0.9        2.73        perf-profile.children.cycles-pp.check_heap_object
      2.52            +1.1        3.60        perf-profile.children.cycles-pp.__check_object_size
      3.08            +1.1        4.18        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      3.23            +1.1        4.38        perf-profile.children.cycles-pp.__kmalloc
      3.38            +1.2        4.56        perf-profile.children.cycles-pp.alloc_msg
      2.25            +1.3        3.53        perf-profile.children.cycles-pp.__slab_free
      4.56            +1.5        6.02        perf-profile.children.cycles-pp.load_msg
      4.17            +1.6        5.80        perf-profile.children.cycles-pp.store_msg
      4.59            +1.8        6.34        perf-profile.children.cycles-pp.do_msg_fill
      4.60            +2.2        6.81        perf-profile.children.cycles-pp.free_msg
      6.36            +3.2        9.61        perf-profile.children.cycles-pp.percpu_counter_add_batch
     25.82 ±  2%      +5.5       31.36        perf-profile.children.cycles-pp.ksys_msgctl
     25.96 ±  2%      +5.6       31.54        perf-profile.children.cycles-pp.msgctl
      6.31            +5.8       12.16        perf-profile.children.cycles-pp._raw_spin_lock
     20.58 ±  2%      +9.4       29.94        perf-profile.children.cycles-pp.msgctl_info
     28.61 ±  3%     +10.1       38.67        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     16.11 ±  3%     +11.6       27.74        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     16.24 ±  3%     +12.9       29.14        perf-profile.children.cycles-pp.__percpu_counter_sum
     26.73           -24.1        2.60        perf-profile.self.cycles-pp.idr_find
      1.00 ±  9%      -0.9        0.06 ±  7%  perf-profile.self.cycles-pp.osq_lock
      1.19 ± 13%      -0.4        0.77 ± 10%  perf-profile.self.cycles-pp.queue_event
      0.87            -0.4        0.47 ±  4%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.41 ±  7%      -0.4        0.06 ±  6%  perf-profile.self.cycles-pp.idr_get_next_ul
      0.29            -0.2        0.05 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      1.04            -0.2        0.86        perf-profile.self.cycles-pp.intel_idle
      0.30            -0.2        0.12 ±  3%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.20 ±  2%      -0.2        0.05        perf-profile.self.cycles-pp.down_read
      0.20            -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.32 ±  2%      -0.1        0.18 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.17 ±  2%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.13            -0.0        0.09        perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.10 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.07            -0.0        0.05        perf-profile.self.cycles-pp.task_mm_cid_work
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.menu_select
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.free_msg
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.06 ±  9%      +0.0        0.07        perf-profile.self.cycles-pp.is_vmalloc_addr
      0.05            +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.kmalloc_slab
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.security_msg_queue_msgrcv
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.check_stack_object
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.__x64_sys_msgsnd
      0.07            +0.0        0.09        perf-profile.self.cycles-pp.number
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp._find_next_or_bit
      0.09 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.security_ipc_permission
      0.09            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__kmalloc
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.12 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.04 ± 45%      +0.0        0.07        perf-profile.self.cycles-pp.format_decode
      0.11            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.load_msg
      0.12 ±  4%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.08            +0.0        0.11        perf-profile.self.cycles-pp.do_msg_fill
      0.08 ±  6%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.10 ±  3%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.store_msg
      0.13 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.13 ±  3%      +0.0        0.16        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.10 ±  4%      +0.0        0.14        perf-profile.self.cycles-pp.wake_up_q
      0.14 ±  4%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.alloc_msg
      0.13            +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__list_add_valid
      0.16 ±  3%      +0.0        0.20        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.02 ±141%      +0.0        0.06        perf-profile.self.cycles-pp.__switch_to
      0.20 ±  2%      +0.0        0.24        perf-profile.self.cycles-pp.__virt_addr_valid
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.vsnprintf
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.09 ±  7%      +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.try_to_wake_up
      0.15 ±  3%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.msgctl_info
      0.15 ±  2%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.refill_obj_stock
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.task_h_load
      0.24 ±  2%      +0.1        0.32 ±  3%  perf-profile.self.cycles-pp.__check_heap_object
      0.06 ± 11%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.cpu_util
      0.35            +0.1        0.43        perf-profile.self.cycles-pp.__get_user_8
      0.20 ±  2%      +0.1        0.29        perf-profile.self.cycles-pp.do_syscall_64
      0.34 ±  2%      +0.1        0.42        perf-profile.self.cycles-pp.__put_user_8
      0.25            +0.1        0.34        perf-profile.self.cycles-pp.ipcperms
      0.34 ±  2%      +0.1        0.42        perf-profile.self.cycles-pp.__entry_text_start
      0.06 ±  7%      +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.idle_cpu
      0.53            +0.1        0.62        perf-profile.self.cycles-pp._copy_from_user
      0.15 ±  2%      +0.1        0.25        perf-profile.self.cycles-pp.kfree
      0.51            +0.1        0.62        perf-profile.self.cycles-pp.__libc_msgrcv
      0.26            +0.1        0.38        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.50            +0.1        0.62        perf-profile.self.cycles-pp.mod_objcg_state
      0.34 ±  3%      +0.1        0.47        perf-profile.self.cycles-pp.__check_object_size
      0.57            +0.1        0.70        perf-profile.self.cycles-pp.__libc_msgsnd
      0.14 ±  6%      +0.2        0.29 ±  3%  perf-profile.self.cycles-pp.security_msg_msg_free
      0.35 ±  2%      +0.2        0.53        perf-profile.self.cycles-pp.ss_wakeup
      0.71 ±  2%      +0.2        0.90        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.62 ±  2%      +0.2        0.83        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.70 ±  2%      +0.2        0.91        perf-profile.self.cycles-pp.stress_msg
      0.21 ±  7%      +0.3        0.47 ±  3%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.47 ±  2%      +0.3        0.78        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.96            +0.3        1.29        perf-profile.self.cycles-pp.do_msgrcv
      1.12            +0.4        1.47        perf-profile.self.cycles-pp._raw_spin_lock
      1.06            +0.4        1.46        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.83 ±  2%      +0.5        1.31        perf-profile.self.cycles-pp.__percpu_counter_sum
      1.48            +0.5        1.99        perf-profile.self.cycles-pp.__kmem_cache_free
      1.52            +0.6        2.17        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      2.08            +0.7        2.76        perf-profile.self.cycles-pp._copy_to_user
      1.57            +0.8        2.34        perf-profile.self.cycles-pp.check_heap_object
      2.22            +1.3        3.49        perf-profile.self.cycles-pp.__slab_free
      3.40            +1.5        4.94        perf-profile.self.cycles-pp.ipc_obtain_object_check
      6.27            +3.2        9.47        perf-profile.self.cycles-pp.percpu_counter_add_batch
      1.10            +3.5        4.63        perf-profile.self.cycles-pp.do_msgsnd
     28.54 ±  3%     +10.0       38.53        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pts/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/msg/stress-ng/60s

commit: 
  bb0b988911 ("iomap: complete polled writes inline")
  f9f8b03900 ("fs: add IOCB flags related to passing back dio completions")

bb0b98891149e2f9 f9f8b03900fcd09aa9906ce7262 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    162720 ±  5%     -15.1%     138144 ±  6%  meminfo.DirectMap4k
     14.69            -0.7       14.01        turbostat.C1%
      5.80            +0.3        6.14        turbostat.C1E%
    539125            -2.9%     523541        vmstat.system.cs
    122778            +2.5%     125857        vmstat.system.in
   1394649            +6.9%    1490914        proc-vmstat.numa_hit
   1394654            +6.9%    1490914        proc-vmstat.numa_local
   1425924            +6.7%    1521059        proc-vmstat.pgalloc_normal
   1016957            +9.5%    1113930 ±  2%  proc-vmstat.pgfree
 1.261e+09            +3.3%  1.303e+09        stress-ng.msg.ops
  21018365            +4.1%   21884422        stress-ng.msg.ops_per_sec
    111.01            +3.8%     115.21        stress-ng.time.user_time
  15445502            -3.2%   14946339        stress-ng.time.voluntary_context_switches
      0.46 ±  5%     +16.4%       0.54 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
     73914 ±  4%     +12.5%      83168        sched_debug.cfs_rq:/.load.max
     18831 ±  2%     +12.8%      21243 ±  2%  sched_debug.cfs_rq:/.load.stddev
    118.55 ±  4%     -17.9%      97.32        sched_debug.cfs_rq:/.load_avg.avg
     60.50 ±  9%     -30.1%      42.29        sched_debug.cfs_rq:/.removed.load_avg.avg
    163.51 ±  3%     -14.2%     140.28        sched_debug.cfs_rq:/.removed.load_avg.stddev
     24.11 ± 14%     -34.3%      15.85 ± 10%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     66.75 ±  8%     -14.2%      57.27 ±  6%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     24.11 ± 14%     -34.3%      15.85 ± 10%  sched_debug.cfs_rq:/.removed.util_avg.avg
     66.75 ±  8%     -14.2%      57.27 ±  6%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    785.18 ±  3%     -11.6%     694.19 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
    760.86 ±  3%     -11.8%     671.44 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
    176.12 ±  5%     -15.1%     149.47 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      0.00 ±  3%     +19.2%       0.00 ± 11%  sched_debug.cpu.next_balance.stddev
      0.48 ±  4%     +15.4%       0.55        sched_debug.cpu.nr_running.stddev
     -9497            -4.0%      -9115        sched_debug.cpu.nr_uninterruptible.min
 1.253e+10            +2.7%  1.287e+10        perf-stat.i.branch-instructions
      0.84            -0.0        0.83        perf-stat.i.branch-miss-rate%
 8.872e+08            +3.9%  9.221e+08 ±  2%  perf-stat.i.cache-references
    560000            -2.9%     543828        perf-stat.i.context-switches
      1.59            -2.3%       1.56        perf-stat.i.cpi
    153320            -5.5%     144952        perf-stat.i.cpu-migrations
      0.02            -0.0        0.02 ±  5%  perf-stat.i.dTLB-load-miss-rate%
   3220864            -8.9%    2935358 ±  5%  perf-stat.i.dTLB-load-misses
 1.585e+10            +2.8%  1.629e+10        perf-stat.i.dTLB-loads
      0.00            -0.0        0.00 ±  3%  perf-stat.i.dTLB-store-miss-rate%
    373490            -8.2%     342822 ±  2%  perf-stat.i.dTLB-store-misses
 9.704e+09            +2.8%   9.98e+09        perf-stat.i.dTLB-stores
 6.431e+10            +2.7%  6.607e+10        perf-stat.i.instructions
      0.64            +2.3%       0.66        perf-stat.i.ipc
    200.87            -3.2%     194.50        perf-stat.i.metric.K/sec
      1082            +2.8%       1112        perf-stat.i.metric.M/sec
      0.75            -0.0        0.73        perf-stat.overall.branch-miss-rate%
      0.29            -0.0        0.28        perf-stat.overall.cache-miss-rate%
      1.62            -2.3%       1.58        perf-stat.overall.cpi
      0.02            -0.0        0.02 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.00            -0.0        0.00 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
      0.62            +2.3%       0.63        perf-stat.overall.ipc
 1.233e+10            +2.7%  1.267e+10        perf-stat.ps.branch-instructions
 8.732e+08            +3.9%  9.074e+08 ±  2%  perf-stat.ps.cache-references
    551127            -2.9%     535164        perf-stat.ps.context-switches
    150891            -5.5%     142643        perf-stat.ps.cpu-migrations
   3170071            -8.9%    2888678 ±  5%  perf-stat.ps.dTLB-load-misses
  1.56e+10            +2.8%  1.603e+10        perf-stat.ps.dTLB-loads
    367588            -8.2%     337366 ±  2%  perf-stat.ps.dTLB-store-misses
  9.55e+09            +2.8%  9.821e+09        perf-stat.ps.dTLB-stores
 6.329e+10            +2.7%  6.502e+10        perf-stat.ps.instructions
 3.995e+12            +2.8%  4.105e+12        perf-stat.total.instructions
      0.04 ± 12%     -36.6%       0.03 ± 24%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.msgctl_info.constprop.0
      0.00 ± 72%    +614.3%       0.02 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
      0.00 ± 40%    +191.7%       0.01 ± 69%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.00 ± 53%     -85.7%       0.00 ±141%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.00 ± 71%   +1563.6%       0.06 ± 53%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
      0.01 ±  8%     -52.9%       0.00 ± 77%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.01 ± 40%    +428.6%       0.04 ± 97%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.01 ± 66%     -91.7%       0.00 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.01 ± 21%     +43.2%       0.02 ± 24%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 93%     -92.3%       0.00 ±101%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.65 ± 37%     +68.8%       1.10 ± 38%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
      1.54 ±  7%    +130.9%       3.55 ± 23%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.generic_file_write_iter.vfs_write.ksys_write
      2.25 ± 26%     -39.4%       1.36 ± 14%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.generic_file_write_iter
      0.12            +9.4%       0.13 ±  5%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    210.94 ±  4%     -12.9%     183.71 ±  9%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    338.14           +22.5%     414.33 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     16.67 ±  2%     +32.0%      22.00 ± 12%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      5.36 ± 29%    +119.6%      11.77 ± 16%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.generic_file_write_iter.vfs_write.ksys_write
     93.05 ± 44%     +86.2%     173.23 ± 20%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      5.35 ± 31%     +79.3%       9.59 ± 12%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
    146.70 ± 44%     -79.0%      30.74 ±  6%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     15.58 ± 26%     -30.8%      10.79 ± 30%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.generic_file_write_iter
      1.54 ±  7%    +130.9%       3.55 ± 23%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.generic_file_write_iter.vfs_write.ksys_write
      0.15 ± 42%     -82.9%       0.03 ±107%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      2.25 ± 26%     -39.4%       1.36 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.generic_file_write_iter
      0.11            +9.9%       0.12 ±  5%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    210.94 ±  4%     -12.9%     183.71 ±  9%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    338.13           +22.5%     414.32 ±  5%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5.36 ± 29%    +119.6%      11.77 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.down_write.generic_file_write_iter.vfs_write.ksys_write
      0.18 ± 37%     -83.3%       0.03 ± 88%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     93.05 ± 44%     +86.2%     173.23 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.44 ± 67%     -55.6%       0.19        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      5.35 ± 31%     +79.3%       9.59 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
    146.70 ± 44%     -79.0%      30.74 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     15.58 ± 26%     -30.8%      10.79 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.generic_file_write_iter
    334.08 ±140%     -99.7%       0.92        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2.72            -1.4        1.35        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.61            -1.3        1.30 ±  2%  perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.11            -1.2        4.96        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      6.02            -1.0        4.99        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     10.63            -0.9        9.71        perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     17.79            -0.9       16.91        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     17.78            -0.9       16.90        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     17.79            -0.9       16.91        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     16.81            -0.8       15.98        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     18.46            -0.8       17.64        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     16.58            -0.8       15.75        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     17.20            -0.8       16.42        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.63            -0.2        3.39        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msgctl
      3.52            -0.2        3.28        perf-profile.calltrace.cycles-pp.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      3.61            -0.2        3.37        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      3.77            -0.2        3.53        perf-profile.calltrace.cycles-pp.msgctl
      1.41 ±  2%      -0.1        1.29        perf-profile.calltrace.cycles-pp.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      1.87            -0.1        1.77        perf-profile.calltrace.cycles-pp.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      1.18            -0.1        1.10        perf-profile.calltrace.cycles-pp.down_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.15            -0.1        1.07        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl.do_syscall_64
      0.76 ±  2%      -0.1        0.69        perf-profile.calltrace.cycles-pp.down_read.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.69            -0.1        0.64        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl.do_syscall_64
      1.36            -0.0        1.32        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.36            -0.0        1.32        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.32            -0.0        1.28        perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      1.38            -0.0        1.34        perf-profile.calltrace.cycles-pp.read
      1.33            -0.0        1.30        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.55            -0.0        0.53        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write
      0.55            -0.0        0.53        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      0.55            -0.0        0.53        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl
      0.78            +0.0        0.81        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.load_msg.do_msgsnd.do_syscall_64
      0.60            +0.0        0.63        perf-profile.calltrace.cycles-pp.mod_objcg_state.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64
      2.03            +0.1        2.09        perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgsnd.stress_run
      0.73            +0.1        0.79 ±  4%  perf-profile.calltrace.cycles-pp.__radix_tree_lookup.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.19            +0.1        1.25        perf-profile.calltrace.cycles-pp._copy_from_user.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.79 ±  2%      +0.1        0.86        perf-profile.calltrace.cycles-pp.ipcperms.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      0.76 ±  3%      +0.1        0.84 ±  7%  perf-profile.calltrace.cycles-pp.__radix_tree_lookup.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.18 ±  2%      +0.1        1.28        perf-profile.calltrace.cycles-pp.__list_del_entry_valid.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      1.68            +0.1        1.79        perf-profile.calltrace.cycles-pp.ss_wakeup.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.97            +0.1        1.09        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      3.46            +0.1        3.59        perf-profile.calltrace.cycles-pp.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.34            +0.1        5.49        perf-profile.calltrace.cycles-pp.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      4.28            +0.2        4.44        perf-profile.calltrace.cycles-pp.store_msg.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.04            +0.2        3.21        perf-profile.calltrace.cycles-pp.__check_object_size.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      1.72 ±  2%      +0.2        1.92        perf-profile.calltrace.cycles-pp.__virt_addr_valid.check_heap_object.__check_object_size.store_msg.do_msg_fill
      2.30 ±  3%      +0.2        2.51        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.92            +0.3       29.19        perf-profile.calltrace.cycles-pp.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      3.49            +0.3        3.76        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      4.71 ±  2%      +0.3        4.98        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      4.21            +0.3        4.48        perf-profile.calltrace.cycles-pp.__slab_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.74            +0.3       34.01        perf-profile.calltrace.cycles-pp.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
     34.73            +0.3       35.03        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
     35.15            +0.3       35.46        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      6.12            +0.3        6.45        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg.do_msgsnd
      6.61            +0.4        6.96        perf-profile.calltrace.cycles-pp.__kmalloc.alloc_msg.load_msg.do_msgsnd.do_syscall_64
      5.67            +0.4        6.02        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      6.81            +0.4        7.17        perf-profile.calltrace.cycles-pp.alloc_msg.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.17            +0.4       38.60        perf-profile.calltrace.cycles-pp.__libc_msgrcv.stress_run
      8.22            +0.4        8.66        perf-profile.calltrace.cycles-pp.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     31.88            +0.5       32.37        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
     10.55            +0.5       11.05        perf-profile.calltrace.cycles-pp.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     32.69            +0.5       33.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
     35.76            +0.7       36.43        perf-profile.calltrace.cycles-pp.__libc_msgsnd.stress_run
     75.45            +1.1       76.57        perf-profile.calltrace.cycles-pp.stress_run
      5.37            -2.7        2.68        perf-profile.children.cycles-pp.idr_find
     12.24            -2.2       10.05        perf-profile.children.cycles-pp.ipc_obtain_object_check
     12.52            -0.9       11.58        perf-profile.children.cycles-pp.intel_idle_irq
     17.79            -0.9       16.91        perf-profile.children.cycles-pp.start_secondary
     18.46            -0.8       17.64        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     18.46            -0.8       17.64        perf-profile.children.cycles-pp.cpu_startup_entry
     18.45            -0.8       17.64        perf-profile.children.cycles-pp.do_idle
     17.21            -0.8       16.43        perf-profile.children.cycles-pp.cpuidle_enter
     17.21            -0.8       16.43        perf-profile.children.cycles-pp.cpuidle_enter_state
     17.45            -0.8       16.67        perf-profile.children.cycles-pp.cpuidle_idle_call
      3.52            -0.2        3.28        perf-profile.children.cycles-pp.ksys_msgctl
      3.81            -0.2        3.57        perf-profile.children.cycles-pp.msgctl
      1.41 ±  2%      -0.1        1.29        perf-profile.children.cycles-pp.msgctl_info
      1.10            -0.1        0.99        perf-profile.children.cycles-pp.down_read
      1.87            -0.1        1.77        perf-profile.children.cycles-pp.msgctl_down
      1.18            -0.1        1.10        perf-profile.children.cycles-pp.down_write
      1.01            -0.1        0.92        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.67            -0.1        0.58        perf-profile.children.cycles-pp.rwsem_wake
      0.26            -0.1        0.18        perf-profile.children.cycles-pp.up_read
      0.23 ±  6%      -0.1        0.15 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.15            -0.1        1.07        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.35 ±  2%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.02            -0.0        0.97        perf-profile.children.cycles-pp.try_to_wake_up
      1.34            -0.0        1.30        perf-profile.children.cycles-pp.vfs_read
      1.32            -0.0        1.28        perf-profile.children.cycles-pp.seq_read_iter
      0.35 ±  4%      -0.0        0.31        perf-profile.children.cycles-pp.sysvipc_proc_start
      0.47 ±  2%      -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.27            -0.0        1.24        perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.50            -0.0        0.48        perf-profile.children.cycles-pp.up_write
      0.47 ±  2%      -0.0        0.45        perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.19 ±  4%      -0.0        0.17        perf-profile.children.cycles-pp.idle_cpu
      0.17 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.msgctl_stat
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.idr_get_next
      0.09            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.set_next_entity
      0.11 ±  4%      -0.0        0.10        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.24            +0.0        0.25        perf-profile.children.cycles-pp.___slab_alloc
      0.17 ±  2%      +0.0        0.18        perf-profile.children.cycles-pp.kmalloc_slab
      0.36 ±  2%      +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.31            +0.0        0.33        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.46 ±  2%      +0.0        0.48        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.21 ±  3%      +0.0        0.23 ±  5%  perf-profile.children.cycles-pp.check_stack_object
      0.36            +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.43            +0.0        0.46        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.39 ±  2%      +0.0        0.42        perf-profile.children.cycles-pp.__percpu_counter_sum
      0.37 ±  3%      +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.80 ±  2%      +0.0        0.84        perf-profile.children.cycles-pp.rep_movs_alternative
      1.33            +0.1        1.39        perf-profile.children.cycles-pp._copy_from_user
      0.46            +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.98            +0.1        1.05        perf-profile.children.cycles-pp.mod_objcg_state
      1.07            +0.1        1.16 ±  2%  perf-profile.children.cycles-pp.ipcperms
      2.61 ±  2%      +0.1        2.70        perf-profile.children.cycles-pp.__entry_text_start
      1.60 ±  3%      +0.1        1.70        perf-profile.children.cycles-pp.__virt_addr_valid
      1.69            +0.1        1.80        perf-profile.children.cycles-pp.ss_wakeup
      1.22 ±  2%      +0.1        1.32        perf-profile.children.cycles-pp.__list_del_entry_valid
      1.56            +0.1        1.68        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.47            +0.1        3.61        perf-profile.children.cycles-pp.__kmem_cache_free
      1.54 ±  2%      +0.1        1.68 ±  6%  perf-profile.children.cycles-pp.__radix_tree_lookup
      5.39            +0.1        5.54        perf-profile.children.cycles-pp.do_msg_fill
      2.67            +0.2        2.82        perf-profile.children.cycles-pp.check_heap_object
      4.33            +0.2        4.50        perf-profile.children.cycles-pp.store_msg
      3.99 ±  3%      +0.2        4.20        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.24            +0.2        5.48        perf-profile.children.cycles-pp.__check_object_size
     29.05            +0.3       29.31        perf-profile.children.cycles-pp.do_msgsnd
      4.22            +0.3        4.48        perf-profile.children.cycles-pp.__slab_free
     33.90            +0.3       34.17        perf-profile.children.cycles-pp.do_msgrcv
      3.51            +0.3        3.78        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      6.27            +0.3        6.60        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      6.63            +0.4        6.98        perf-profile.children.cycles-pp.__kmalloc
      6.86            +0.4        7.22        perf-profile.children.cycles-pp.alloc_msg
     38.25            +0.4       38.66        perf-profile.children.cycles-pp.__libc_msgrcv
      8.26            +0.4        8.70        perf-profile.children.cycles-pp.free_msg
     10.62            +0.5       11.14        perf-profile.children.cycles-pp.load_msg
     72.15            +0.5       72.69        perf-profile.children.cycles-pp.do_syscall_64
     73.14            +0.5       73.68        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.90 ±  2%      +0.6       11.52        perf-profile.children.cycles-pp._raw_spin_lock
     35.80            +0.7       36.45        perf-profile.children.cycles-pp.__libc_msgsnd
     75.45            +1.1       76.57        perf-profile.children.cycles-pp.stress_run
      5.32            -2.7        2.64        perf-profile.self.cycles-pp.idr_find
     12.42            -0.9       11.49        perf-profile.self.cycles-pp.intel_idle_irq
      0.28 ±  3%      -0.1        0.22 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.30            -0.0        0.25        perf-profile.self.cycles-pp.store_msg
      0.11 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__schedule
      0.08            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.down_read
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__kmalloc
      0.15            +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.kmalloc_slab
      0.32            +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.68 ±  2%      +0.0        0.70        perf-profile.self.cycles-pp.__check_object_size
      0.16 ±  2%      +0.0        0.19 ±  5%  perf-profile.self.cycles-pp.check_stack_object
      0.37            +0.0        0.40 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.36 ±  3%      +0.0        0.39 ±  2%  perf-profile.self.cycles-pp.__list_add_valid
      0.55 ±  2%      +0.0        0.59 ±  2%  perf-profile.self.cycles-pp.rep_movs_alternative
      1.09            +0.0        1.14 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.41            +0.1        0.47        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.94            +0.1        1.01        perf-profile.self.cycles-pp.mod_objcg_state
      1.59 ±  3%      +0.1        1.67        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.06            +0.1        1.14 ±  2%  perf-profile.self.cycles-pp.ipcperms
      2.48            +0.1        2.57        perf-profile.self.cycles-pp.__kmem_cache_free
      1.21 ±  2%      +0.1        1.30        perf-profile.self.cycles-pp.__list_del_entry_valid
      1.25 ±  3%      +0.1        1.36        perf-profile.self.cycles-pp.do_syscall_64
      1.68            +0.1        1.80        perf-profile.self.cycles-pp.ss_wakeup
      1.53 ±  2%      +0.1        1.67 ±  6%  perf-profile.self.cycles-pp.__radix_tree_lookup
      1.50            +0.2        1.66        perf-profile.self.cycles-pp.check_heap_object
      3.91 ±  3%      +0.2        4.11        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      3.10            +0.2        3.34        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      2.80            +0.2        3.05        perf-profile.self.cycles-pp.do_msgsnd
      4.18            +0.3        4.45        perf-profile.self.cycles-pp.__slab_free
      3.34            +0.3        3.65        perf-profile.self.cycles-pp.do_msgrcv
      5.27            +0.4        5.63        perf-profile.self.cycles-pp.ipc_obtain_object_check
      7.11            +0.4        7.47        perf-profile.self.cycles-pp._raw_spin_lock





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--uR47BtlQtO/Ptsyx
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.5.0-rc1-00002-gf9f8b03900fc"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.5.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_CACHESTAT_SYSCALL=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_INTEL_TDX_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HOTPLUG_CORE_SYNC=y
CONFIG_HOTPLUG_CORE_SYNC_DEAD=y
CONFIG_HOTPLUG_CORE_SYNC_FULL=y
CONFIG_HOTPLUG_SPLIT_STARTUP=y
CONFIG_HOTPLUG_PARALLEL=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB_DEPRECATED is not set
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y
CONFIG_LOCK_MM_AND_FIND_VMA=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_INTEL_MEI_GSC_PROXY is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ELKHARTLAKE is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_MAX31827 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
# CONFIG_SENSORS_HP_WMI is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77541 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS6594_I2C is not set
# CONFIG_MFD_TPS6594_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_IO_HELPERS=y
CONFIG_FB_SYS_HELPERS=y
CONFIG_FB_SYS_HELPERS_DEFERRED=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# CONFIG_TYPEC_MUX_NB7VPQ904M is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_AW200XX is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y

#
# VFIO support for PCI devices
#
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
# end of VFIO support for PCI devices

CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_GENIV=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_JITTERENTROPY_TESTINTERFACE is not set
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_FLAGS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SLUB_DEBUG is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
# CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set
# CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_FUNCTION_GRAPH_RETVAL is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--uR47BtlQtO/Ptsyx
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='stress-ng'
	export testcase='stress-ng'
	export category='benchmark'
	export nr_threads=64
	export testtime=60
	export job_origin='stress-ng-class-pts.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='lkp-icl-2sp7'
	export tbox_group='lkp-icl-2sp7'
	export branch='axboe-block/xfs-async-dio'
	export commit='f9f8b03900fcd09aa9906ce72627ba23d818ff8d'
	export submit_id='64bf65f90b9a934b281c8a22'
	export job_file='/lkp/jobs/queued/vip/lkp-icl-2sp7/stress-ng-pts-performance-100%-msg-60s-debian-11.1-x86_64-20220510.cgz-f9f8b03900fc-20230725-84776-1cgz8pd-2.yaml'
	export id='9130ceec5d5cc33d07b51056c77ca32f4f0bdf2c'
	export queuer_version='/lkp/xsang/.src-20230725-100951'
	export model='Ice Lake'
	export nr_node=2
	export nr_cpu=64
	export memory='256G'
	export nr_ssd_partitions=3
	export nr_hdd_partitions=6
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD20SPZX-22UA7T0_WD-WXK2E319F11A-part*'
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part1
/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part2
/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part3'
	export rootfs_partition='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part4'
	export kernel_cmdline_hw='acpi_rsdp=0x6988f014'
	export result_service='tmpfs'
	export LKP_SERVER='10.239.97.5'
	export avoid_nfs=1
	export brand='Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz'
	export need_kconfig=\{\"XFS_DEBUG\"\=\>\"n\"\}'
'\{\"XFS_WARN\"\=\>\"y\"\}'
'\{\"PM_DEBUG\"\=\>\"n\"\}'
'\{\"PM_SLEEP_DEBUG\"\=\>\"n\"\}'
'\{\"DEBUG_ATOMIC_SLEEP\"\=\>\"n\"\}'
'\{\"DEBUG_SPINLOCK_SLEEP\"\=\>\"n\"\}'
'\{\"CIFS_DEBUG\"\=\>\"n\"\}'
'\{\"SCSI_DEBUG\"\=\>\"n\"\}'
'\{\"NFS_DEBUG\"\=\>\"n\"\}'
'\{\"SUNRPC_DEBUG\"\=\>\"n\"\}'
'\{\"DM_DEBUG\"\=\>\"n\"\}'
'\{\"DEBUG_SHIRQ\"\=\>\"n\"\}'
'\{\"OCFS2_DEBUG_MASKLOG\"\=\>\"n\"\}'
'\{\"DEBUG_MEMORY_INIT\"\=\>\"n\"\}'
'\{\"EXPERT\"\=\>\"y\"\}'
'\{\"PREEMPT_VOLUNTARY\"\=\>\"y\"\}'
'\{\"PREEMPT_NONE\"\=\>\"n\"\}'
'\{\"PREEMPT\"\=\>\"n\"\}'
'\{\"PREEMPT_RT\"\=\>\"n\"\}'
'\{\"PREEMPT_DYNAMIC\"\=\>\"n\"\}'
'\{\"PREEMPT_VOLUNTARY_BEHAVIOUR\"\=\>\"y\"\}'
'\{\"PREEMPT_BEHAVIOUR\"\=\>\"n\"\}'
'\{\"PREEMPT_NONE_BEHAVIOUR\"\=\>\"n\"\}'
'\{\"PREEMPT_DYNAMIC\"\=\>\"n\"\}'
'\{\"PREEMPT_VOLUNTARY\"\=\>\"y\"\}'
'\{\"PREEMPT_NONE\"\=\>\"n\"\}'
'\{\"PREEMPT\"\=\>\"n\"\}'
'\{\"PREEMPT_RT\"\=\>\"n\"\}
	export ucode='0xd000389'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export kconfig='x86_64-rhel-8.3'
	export enqueue_time='2023-07-25 14:04:47 +0800'
	export compiler='gcc-12'
	export _id='64bf66000b9a934b281c8a36'
	export _rt='/result/stress-ng/pts-performance-100%-msg-60s/lkp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d'
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d/vmlinuz-6.5.0-rc1-00002-gf9f8b03900fc'
	export result_root='/result/stress-ng/pts-performance-100%-msg-60s/lkp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d/3'
	export user='lkp'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/stress-ng/pts-performance-100%-msg-60s/lkp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d/vmlinuz-6.5.0-rc1-00002-gf9f8b03900fc
branch=axboe-block/xfs-async-dio
job=/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-pts-performance-100%-msg-60s-debian-11.1-x86_64-20220510.cgz-f9f8b03900fc-20230725-84776-1cgz8pd-2.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=f9f8b03900fcd09aa9906ce72627ba23d818ff8d
nmi_watchdog=0
acpi_rsdp=0x6988f014
max_uptime=2100
LKP_SERVER=10.239.97.5
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/stress-ng_20230716.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/stress-ng-x86_64-0.15.04-1_20230716.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20230522.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rootfs_20220515.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-pts-performance-100%-msg-60s-debian-11.1-x86_64-20220510.cgz-f9f8b03900fc-20230725-84776-1cgz8pd-2.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_setup $LKP_SRC/setup/sanity-check

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-c2c
	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test class='pts' test='msg' $LKP_SRC/tests/wrapper stress-ng
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env class='pts' test='msg' $LKP_SRC/stats/wrapper stress-ng
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-c2c
	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time stress-ng.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--uR47BtlQtO/Ptsyx
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! /lkp/lkp/src/jobs/stress-ng-class-pts.yaml
suite: stress-ng
testcase: stress-ng
category: benchmark
nr_threads: 100%
testtime: 60s
stress-ng:
  class: pts
  test: msg
job_origin: stress-ng-class-pts.yaml

#! queue options
queue_cmdline_keys: []
queue: vip
testbox: lkp-icl-2sp7
tbox_group: lkp-icl-2sp7
branch: axboe-block/xfs-async-dio
commit: f9f8b03900fcd09aa9906ce72627ba23d818ff8d
submit_id: 64bf65f90b9a934b281c8a22
job_file: "/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-pts-performance-100%-msg-60s-debian-11.1-x86_64-20220510.cgz-f9f8b03900fc-20230725-84776-1cgz8pd-1.yaml"
id: 9ccc8839945e9d5233b119268908e76d83e4b24e
queuer_version: "/lkp/xsang/.src-20230725-100951"

#! hosts/lkp-icl-2sp7
model: Ice Lake
nr_node: 2
nr_cpu: 64
memory: 256G
nr_ssd_partitions: 3
nr_hdd_partitions: 6
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD20SPZX-22UA7T0_WD-WXK2E319F11A-part*"
ssd_partitions:
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part1"
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part2"
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part3"
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part4"
kernel_cmdline_hw: acpi_rsdp=0x6988f014
result_service: tmpfs
LKP_SERVER: 10.239.97.5
avoid_nfs: 1
brand: Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz

#! include/category/benchmark
need_kconfig:
- XFS_DEBUG: n
- XFS_WARN: y
- PM_DEBUG: n
- PM_SLEEP_DEBUG: n
- DEBUG_ATOMIC_SLEEP: n
- DEBUG_SPINLOCK_SLEEP: n
- CIFS_DEBUG: n
- SCSI_DEBUG: n
- NFS_DEBUG: n
- SUNRPC_DEBUG: n
- DM_DEBUG: n
- DEBUG_SHIRQ: n
- OCFS2_DEBUG_MASKLOG: n
- DEBUG_MEMORY_INIT: n
- EXPERT: y
- PREEMPT_VOLUNTARY: y
- PREEMPT_NONE: n
- PREEMPT: n
- PREEMPT_RT: n
- PREEMPT_DYNAMIC: n
- PREEMPT_VOLUNTARY_BEHAVIOUR: y
- PREEMPT_BEHAVIOUR: n
- PREEMPT_NONE_BEHAVIOUR: n
- PREEMPT_DYNAMIC: n
- PREEMPT_VOLUNTARY: y
- PREEMPT_NONE: n
- PREEMPT: n
- PREEMPT_RT: n
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-c2c:
perf-profile:
  debug_mode: 0

#! include/category/ALL
cpufreq_governor: performance
sanity-check:

#! include/stress-ng

#! include/testbox/lkp-icl-2sp7
ucode: '0xd000389'
rootfs: debian-11.1-x86_64-20220510.cgz
kconfig: x86_64-rhel-8.3
enqueue_time: 2023-07-25 14:04:47.791869089 +08:00
compiler: gcc-12
_id: 64bf66000b9a934b281c8a35
_rt: "/result/stress-ng/pts-performance-100%-msg-60s/lkp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d"
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d/vmlinuz-6.5.0-rc1-00002-gf9f8b03900fc"
result_root: "/result/stress-ng/pts-performance-100%-msg-60s/lkp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d/0"

#! schedule options
user: lkp
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/stress-ng/pts-performance-100%-msg-60s/lkp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d/vmlinuz-6.5.0-rc1-00002-gf9f8b03900fc
- branch=axboe-block/xfs-async-dio
- job=/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-pts-performance-100%-msg-60s-debian-11.1-x86_64-20220510.cgz-f9f8b03900fc-20230725-84776-1cgz8pd-1.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=f9f8b03900fcd09aa9906ce72627ba23d818ff8d
- nmi_watchdog=0
- acpi_rsdp=0x6988f014
- max_uptime=2100
- LKP_SERVER=10.239.97.5
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-12/f9f8b03900fcd09aa9906ce72627ba23d818ff8d/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/stress-ng_20230716.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/stress-ng-x86_64-0.15.04-1_20230716.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20230522.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rootfs_20220515.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20230725104851/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
job_initrd: "/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-pts-performance-100%-msg-60s-debian-11.1-x86_64-20220510.cgz-f9f8b03900fc-20230725-84776-1cgz8pd-1.cgz"
dequeue_time: 2023-07-25 14:08:23.526339263 +08:00
last_kernel: 6.5.0-rc3-01184-g572f943de997
acpi_rsdp: '0x6988f014'
job_state: finished
loadavg: 31.71 14.59 5.44 1/757 6916
start_time: '1690265265'
end_time: '1690265327'
version: "/lkp/lkp/.src-20230724-143308:db5c288cdcbb:71668ffc9b45"

--uR47BtlQtO/Ptsyx
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "stress-ng" "--timeout" "60" "--times" "--verify" "--metrics-brief" "--msg" "64"

--uR47BtlQtO/Ptsyx--
