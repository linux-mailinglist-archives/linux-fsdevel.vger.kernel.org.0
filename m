Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476FA74B25E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 16:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjGGOBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 10:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjGGOA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:00:59 -0400
X-Greylist: delayed 1935 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Jul 2023 07:00:51 PDT
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4F41FE8
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 07:00:51 -0700 (PDT)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44]) by mx-outbound44-122.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 07 Jul 2023 14:00:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii26JqL0qqv+6CRoBvj2oXxA5+8Mo/yEV2NWQo+C0dluNuA4cawMbX0c0Y6FtjOh6R6BOr5CwM3JBlr/621OROjb5VzNd3Q0PXbPlW6KneqVXm/xQ8Z6iRFiwzOSnQDGg9X95ILwqyTYilcousSZHSoSankbt9Zn62QlNiHEeUjzcxmYMW2df73uhqu3iQabJApXcg0Zw19jSGLVdIsUHfGx+EQZHdY0ohWGsutnuI2S6E3Dd9D4sw7nhF/aDVV/oUfFUwno80Eemogzak5ucg/gFMsKsU59mp6ivPDk697T45dG5q8OeznC0LH0ry6gQjghYJ9FgM/rKHgSZsUTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A0BJJHgCWggrkMfle+yO+0J88DwE4uvCQJ19otykj0=;
 b=aoCv4KAqpdJZq6X1gFPwQbLVVEIsMV13vkJ2KRcNDW0K8xmJGnwyfbcqBCpHFxMNL7Jea6D5ZamKpucbcrUHTvwwe+BHimH3uZVyhfaSGOFf/x0DptBu/aUplTUW6RPgz7CX04UET/T2y4XOqPKs91mhvZ2u2AwxSrgLQAXDn7UwR4ks578URN3GHeOCgZ0dYzndTuD1GebNpBTiH5c+/iMrnCpQwDNmvIzx5Ct/zYn1RUQFmSBQPWJXxquHehR6yd3wQWt77Z4qwE6o/+gPwimeK7OumZyAzQhAOaWJKtnV5bST811csZyUxqAsWq/4RuI6lWLi1Y36byR59gC5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A0BJJHgCWggrkMfle+yO+0J88DwE4uvCQJ19otykj0=;
 b=t8NVXpZN2+MOFujwa3cURX74y61+CkLuGkleSyKaeMJ74U3/IjAVghqgaX87aIdWTy8J+7rXGg0mSERTKC1SBdEKS/lPmGJG1hcU+3vBeRAmh4ipTmHe8P9eLQCPIoKwwQLkO1+04qYpP18RaakFPQB+8zORxXhdH+aAiHG+V/0=
Received: from DM6PR07CA0099.namprd07.prod.outlook.com (2603:10b6:5:337::32)
 by MW4PR19MB6578.namprd19.prod.outlook.com (2603:10b6:303:1e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.17; Fri, 7 Jul
 2023 13:28:10 +0000
Received: from DM6NAM04FT013.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::84) by DM6PR07CA0099.outlook.office365.com
 (2603:10b6:5:337::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 13:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT013.mail.protection.outlook.com (10.13.158.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.13 via Frontend Transport; Fri, 7 Jul 2023 13:28:09 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 1C20520C684C;
        Fri,  7 Jul 2023 07:29:15 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu,
        fuse-devel@lists.sourceforge.net, vgoyal@redhat.com,
        dsingh@ddn.com, Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v6 0/2] FUSE: Implement full atomic open
Date:   Fri,  7 Jul 2023 15:27:44 +0200
Message-Id: <20230707132746.1892211-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT013:EE_|MW4PR19MB6578:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8297b831-edf3-4f7d-6d35-08db7eee01bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMoqpHPRz2iNQWqHWklptnH03eA61pBcZhCeRc31J7pQe6/j/DmKvWArePtQ6ZTCFzJyPxXvR3BasyAB1NQRvoxFLZs8/xutAw7FBS9PbJCevkNp/awklnI3K0r7JTISuIapPKa6h0fE4C3Sw9cfUHpBtjBhdXW/owSIF+wNO5CCybiTAGSyNeKxwQAmKe/PjJ9krhaNU3Rzjbmoi3PvqbpiEQWd3UtTszWYagSsT979ZwlrGimEDrDF8pv9AgHzSMXfepq8EtohLuNwnNv59ZJkrdVaBB2UdGmIGb2DwAKmZBA5JhtCKZ8J0jjyDgNsB5obOMmlR3Ce6YtUo1xLYP56O1NyiKV5fQhO909r1d1jzC9akccdTvGYW5kCeVeP2W37IK6wl7U4CJj+5IHMucJXijUuON8mTTHW37cq10wkzf1p7KP7HniJ44wfaYVOc6SVi1k3MpA1rzv+/9E1kSenuKndWUkYIHKrHMo1T+GlVQxwL3Q7S7pffTezC3QyDfSyT6K7WhIyJNWTSIEJTlI0p+TM+WORJBK5zjO1rIgae29jHKWCwndcNETjFLQCXIhgmYMPA6hbCSgP6h+rv/eFj+AnDxiC6+HcUd/fNIB94MUVWuSAFrbUa9IawzxgW0p/dFurNdp4wdWP5NpweOABx32Z6c1FAstwCZBH4aLE1XiXuu6CMhsTg/4fC0I6XvAKhqfJjgNQgFsFMxDFAOpd0ysAqx8z0dAERGcEw7kg8+p3/h2Ojagm463j1YkG9ZZxiULandcq1QLp+uZhWQ==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39850400004)(451199021)(36840700001)(46966006)(478600001)(6666004)(26005)(966005)(186003)(36756003)(2906002)(6266002)(82310400005)(70206006)(8676002)(8936002)(5660300002)(4326008)(6916009)(81166007)(41300700001)(70586007)(316002)(82740400003)(356005)(1076003)(36860700001)(2616005)(47076005)(86362001)(336012)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6Rf10AfCcp/Cj/eUcle8BFnN1j64dC4IQxREPCwZCTWCTLeO0N1vMfHUe1Oj?=
 =?us-ascii?Q?fv971+yUlNBE+w5+JCEATlcFM9oyjOwzXcaE/jymEPr67Guimn6weUABb1Pe?=
 =?us-ascii?Q?vYIaqoanWqAr9ZQzF4F/O4wG8+zs+aFlveX7GYfb3PuXhPhNzzEUCqZxS5FW?=
 =?us-ascii?Q?wybSrgrTFb0+h1HSA4NR0AiRamJGF2UbkdMOwubpztwlr4n7oTvrIcKho6/P?=
 =?us-ascii?Q?jIIaJ1qWIZgZdFi+vnk2NB1MumPOpad2MU1c6noExetr4cb8PCYeD+FzYhWG?=
 =?us-ascii?Q?IQrlxtjVqmfnHNwXGV+cPUTyiOh6btbHsEfL2ZuPo/ITf97tIj7PeV4o7Zqq?=
 =?us-ascii?Q?E42YHe/nNy/oCt+scN9ewO7TR+Cn974V/OzJP2kWNwteON+VlF2QdXKEvPXb?=
 =?us-ascii?Q?SOKBa2hIyUjXdWuPiubTKLnug2UUfXOw32euQzeg7sVxBQh5ARWsKsVUSaMQ?=
 =?us-ascii?Q?kObcxvQvM+1eSF/oBGBabpv5B4RS8lNvcDaQZIcoG+MK030ixHlkTO6/Fy4B?=
 =?us-ascii?Q?nDLlxyw+AU/T+fh+zNdbu7Vz8U7dP0dwYJfo1+utfjORvfKqA2uoK2SLq5vZ?=
 =?us-ascii?Q?UQJLNOE/d4tbve5+JeqUFGkBipQdUmIwkrBPwfTjf1UNHxBdRpgHpOc6VzE3?=
 =?us-ascii?Q?y6uKWm+PJYhnI0EvduHZFQEdptqCrFb3UeiaozOJqDjyJnNdrsIAQGyT4ZuP?=
 =?us-ascii?Q?gAvyFYRWAax03G7R8ZjL2ampz+1F1Po2W6VnYNAVuM86YSSUfOM/ZBvFmjSf?=
 =?us-ascii?Q?ZxmNmsIWWFOiPhWirqdG/0A3iYKUlhpJ0jSwSgvF/sAdYSwxMqdCh5rB8KkO?=
 =?us-ascii?Q?egxifGBZSNC12YUodSdWzoSzhuswyXVovPg3C6gh2cWlV0ZyjcWjCvlZrIqR?=
 =?us-ascii?Q?TqEn5XmQe3Acd7H9MpHNAFKTWirVI/UrKcoi6jVMEOWd+lO1J51KTiPOPVTS?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 13:28:09.8914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8297b831-edf3-4f7d-6d35-08db7eee01bf
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT013.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6578
X-BESS-ID: 1688738437-111386-5560-12484-1
X-BESS-VER: 2019.1_20230706.1616
X-BESS-Apparent-Source-IP: 104.47.56.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamxuZAVgZQMMXC0DzVMskiNS
        nRINXEyMLEJDnN2MLY1MQs2czCIClZqTYWAGcEXh1BAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.249330 [from 
        cloudscan11-73.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In FUSE, as of now, uncached lookups are expensive over the wire.
E.g additional latencies and stressing (meta data) servers from
thousands of clients. With atomic-open lookup before open
can be avoided.

Here is the link to performance numbers
https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@gmail.com/

Here is the libfuse pull request
https://github.com/libfuse/libfuse/pull/813

The patches are passing passthrough_hp xfstests (libfuse part applied),
although we had to introduce umount retries into xfstests, as recent
kernels/xfstests fail umount in some tests with
EBUSY - independent of atomic open.

v6: Addressed Miklos comments and rewrote atomic open into its own
    function and fuse opcode. 
    Dropped for now is the revalidate optimization, we
    have the code/patch, but it needs more testing. Also easier to
    first agree on atomic open and then to land the next optimization.

v5: Addressed comments

v3: Addressed comments

v4: Addressed all comments and refactored the code into 3 separate patches
    respectively for Atomic create, Atomic open, optimizing lookup in
    d_revalidate().


v3: handle review comments

v2: fixed a memory leak in <fuse_atomic_open_common>


Bernd Schubert (1):
  fuse: rename fuse_create_open

Dharmendra Singh (1):
  fuse: introduce atomic open

 fs/fuse/dir.c             | 176 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |   3 +
 include/uapi/linux/fuse.h |   3 +
 3 files changed, 178 insertions(+), 4 deletions(-)

-- 
2.37.2

