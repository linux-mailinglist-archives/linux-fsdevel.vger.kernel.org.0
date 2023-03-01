Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E286A6827
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 08:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCAHca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 02:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCAHc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:32:28 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70F392AB;
        Tue, 28 Feb 2023 23:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677655943; x=1709191943;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=E00KOKg5e4JXCXnqGsiitm34ePsIP1bMyTBgYKpt244=;
  b=JJp0zuOslaYK7I1vs+K5OMGUFqO8Ox61DKm6z/ggimOobefUxWK4Lde9
   cv40VY+nj9PiM+scOryqkCyIOvM2yzliDoewB9SnEmKFTCc+eqNvwg986
   ztC047l0uEHzb9XROYETx1+vysjq1jzvdTUzBHHR04fuYMYdcjFUziajD
   oAVTdG5eRXepw0dp/CNLZ4AMgPGX4E66LjJlPV+TPPWWCbOcII+q1nrIi
   JJbWuSqbNpqGcu4qtFSbM+C2SMTENLKgjgmQTbNNQ27EK4aKOzFx+c8xx
   aHwKJuLYBKIVf51fupYNQy92NxuzF/bXSdUn+6dI+CLed9gmuCxpHjuqv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="399125120"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="399125120"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 23:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="1003551954"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="1003551954"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2023 23:31:58 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 23:31:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 23:31:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 23:31:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9RoaPLpNzAFLLzAjrBXUmA8IyCWLYNgxIZ99aUD9rgM4qDSA5vwZo1wtoNtCK3RqO/M2mh//x0LPXBR7GY4Ob9ohUrtHktOT+2RGVskuYOXtVZnogwyeviIYwXPOT/fGb1Axwb987d75axt7SvPPnV4Dhy2fblcYjOxaznDxtmmbpHjV8JgXPKpDRZmBM702wVaH+vxva05VCWOrfh5XDrod5vU1oq/NFQZTj1vKbtzz1YCwRt+8uzC34cNkIekUvOCKtLMAO7sjYuJLcGyfYidk40kpBa2L+hiKn2DZJasYYXwmiT7ypenIkmN5FbGhIlYHaMcdhJGdRr2bYCOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVU2cdcQGYxJmcfFdgBHRccTY2kVekMjwzWqosAjBfw=;
 b=XZ8L/i0rIzBkApdptvvES7n7eH2H30LJysPztZ0qVEx47uaivJFKmuhsS/wgS6MtANVSFuoyG64FqcZ/B0S3Lj2+aW+8vAP9WI0jcaFVYZxVqgNVYkvsC38K+l2KsWdf9dN5Gn4Xs2E1gUrslnuv0fFhGXdAbN4Gs/WkcQjXXIR0P0z7/fOqpoBUzYGt5MXiGCPJTEKG+uQvzfruP+44OFpSGQar8hwXtojUr4SWjckdlfyPWKWiYkKq7NDU74fDr+998qiuXqHsZ4Nm9N4YAUYoy7G/OXTupsMBu/YPyh9seRUZNh3J9vBEHZLrrCdJ62NU4MpcQKdnJ7pfwwMp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS7PR11MB6126.namprd11.prod.outlook.com (2603:10b6:8:9e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.28; Wed, 1 Mar 2023 07:31:53 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4%7]) with mapi id 15.20.6134.028; Wed, 1 Mar 2023
 07:31:53 +0000
Date:   Wed, 1 Mar 2023 15:31:42 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [linus:master] [mm/mmap]  0503ea8f5b: kernel_BUG_at_mm/filemap.c
Message-ID: <Y/7/XrLlDw+cimEw@xsang-OptiPlex-9020>
References: <202302252122.38b2139-oliver.sang@intel.com>
 <20230227031756.v57rhicna3tjbavw@revolver>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230227031756.v57rhicna3tjbavw@revolver>
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS7PR11MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: e15c3194-58c9-4e56-d2cd-08db1a2706d7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGoD5WbtL8Kv29Nlk9LLk/z4VYQ798x7bh0YDAFiBl5CzHqxBtrRO3XCt7JmHgywWybo+Ucd7cr4iRG+3bkfO2H64BAI6TU7Hst0kLPEnCemnTDWTOCOFwJKHPVXeuYE51Qus5xzy9Pto7AnWkZ52jmhc72Y7yOxPk3OvAPJos4jPFezlPE/a6zXZk+dA9v/Wdcab6ivm34C07oFdoXC5KYO3gAYKWQsJnW8gMphdv3MWJlOrGLZBkqjUICce+tQpvRTm5ebXzOLu3KjaaC6bvpNt+xDBLSW6XiK2Jk79fv6ITrOHRZkbuG5fuiop028kQpfwl5No7aEj0K3G6NkcMxIbpRfojrr6B5zY1k//ILiI+CcC1276HL3JQzOnPXy4LL2mouDnV38DHI/HzG2RvnuRrm12IlMXl066y1mzk05r/qxwT4UOi5JniihJBKg5vk1IYosM0HWP3D1UpWvzIfAzYn3TjMtvP+W4ELDfxobSfD5ApzHDXaspdXr6iUap8qt/H3lFEwzR0H/zGo0tHWCbFjF9dp59pN9sRqkOlRYUWubDUtJ0pvLP8qoKZ7hdnREQOpTpqDWmOFoFSY9f8d23jMc1gkK5Kmd0UAYaPJYbZ//k84o7Tr0dasON4jK0p3E9qaE9aY5vSUaa4pWspmdXjVuR/KvTUW4zjykJQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199018)(110136005)(316002)(86362001)(33716001)(26005)(38100700002)(82960400001)(6506007)(6512007)(83380400001)(41300700001)(186003)(9686003)(6666004)(2906002)(8936002)(30864003)(478600001)(6486002)(966005)(66946007)(44832011)(66556008)(8676002)(5660300002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dp/cNJVgTfElCwWIPmf9A84mgIKXWM/2c7bOdkt368Vloh2DVfpj4bxU7TcX?=
 =?us-ascii?Q?2YHG+fVWxZLMNhqf/GrscQyhX2yUEYZcHdWEXUHFvDsZyE2zOUrPCDFinsAB?=
 =?us-ascii?Q?jjIST8DJnl3JwfJQ7ObIGA2wgjnMRJQiGKu9u/tvj56YbjG6d6eKhn4Hx78l?=
 =?us-ascii?Q?Ab9JHZoUVVFVD3gWdAUG3l/XJSrFS+F7K3BUz+EJMI5YANlaomisWZXJ62lV?=
 =?us-ascii?Q?v/WjrqDGqI8eWevNQ2bCX7j0Gn8ykhvh5zY8bMfQbzX5j5RN4J6CSVD10DzT?=
 =?us-ascii?Q?rIjp6VBTa/YQYShX7nHJ6dUHH9T2Telb2tbunOuOuQ5lJ765zo5T2QB1LP4w?=
 =?us-ascii?Q?WJeKlPb5lN+m9PVIZLJGxqRYs8aIAMYVTCVa3+iI3LdddnLKUfw9FCTaFK7e?=
 =?us-ascii?Q?ikew1rceg9rYrq4zGUeJ1UhBv8WU+RSqW4CfXiWOLKTfAy4ciWVqdYrJS7OB?=
 =?us-ascii?Q?xvBk+Lj9GMNUuiCEEdYqVqsZZyfc0hF2BI3JnStpLs7y/oBOEzUqDNAP4xnd?=
 =?us-ascii?Q?9MVQs/J3EH4sgyxMmp56ywKKgbYuiC7f//LvJV4oNjQQPEVZCnRR+JM1XKWh?=
 =?us-ascii?Q?ZE5YxcdzB55yvnwj2fXm0OuAw/OgJqO3HlPuXWUv7UOSAMeTVZuZAfmsVMKD?=
 =?us-ascii?Q?TfSUZQJ4Gnuf/jz29Xl1n9eHbMV9YUZqBMfO/kfYALWkHZOrbqvqWOD44kYK?=
 =?us-ascii?Q?g/Ho4RHb3GaBj381it5wxsObDV3sAvfPpJooSqzpBiu7lJmiGOwOleHHwzzc?=
 =?us-ascii?Q?VGmjHjsyVRO1TmPmqpwb+tBUbhYdcnGZX901pdSEGvr/aZ8n6J8s39wm3viM?=
 =?us-ascii?Q?w2qerjjJyLx7T9MsN3oKXk4Jq+Vxe+LobHcgDfV5josLFNza6Yt1lUoMcKVX?=
 =?us-ascii?Q?nKSGGYtI1FUwh/T+63BDOkP9eOrsqUSO8WqyhBhrJUqCy2sV3fAH5OUgBjLu?=
 =?us-ascii?Q?fyZTfSLFUFovX8b3Peh3MY8y19t+PyjQPXyMpm0HFWFai5OnJn/Gxclj6yjm?=
 =?us-ascii?Q?ppHvUL05jmHfNJkcZkseT/qxfwxAstbVhczmERlIIx+4QtkTyEjNWsu6RRdV?=
 =?us-ascii?Q?oGKzvMNWi5a9ltNydv2uwBpIsvPkRuXmkm/d7C4hGSQCgKeUs5eG4q0TwwVj?=
 =?us-ascii?Q?Q4pwQ3aKOEu1WS3162vJPRZruPS7yrZCv0yn8cfCxknQu+i0cOLKmYF8PWt4?=
 =?us-ascii?Q?Ar/DEc1w3uJoOIQZxwpHPlBztJYbIsLhiy7bCVqohxOQKQ06qK6G9JXRU0u/?=
 =?us-ascii?Q?k8ZyrybNlUW9/tfpYgxtrjazY4m/3i/RfYJRRcYcMmD8AudR2izef7EyM/wo?=
 =?us-ascii?Q?F+LwUgclZzw+2Py4fpCm2p8PoYTtPaGHuiz/+wdBA4Xag3//AZwlnC5ig20P?=
 =?us-ascii?Q?eOXKBImH2hFRHbeOeON4BiZW3lqmPjHjChF91j+PB/Oefmm2rAxYgO8p5Xx0?=
 =?us-ascii?Q?MfxuoQJtE86kVkDhdj6pGmDDeR2po0MzSl6WDGNdRNvGfwJ40q4fuc+LrfJh?=
 =?us-ascii?Q?lBaqpkyKopq6BGVWRLPCDeXyJo2AEYOrySLBZMqx1EIzK3x9XTtS9ZiSAr2N?=
 =?us-ascii?Q?L1jZuws+1Lld1oz0BiI3NdD0qjamgotDjGg8QaZGy3QOrJJHo7bjTwdXhJtl?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e15c3194-58c9-4e56-d2cd-08db1a2706d7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 07:31:52.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oDKSDgOguHjaSTlWvSGg3r9xXVAT61wbNh9HtbcG8X0nw25YWlEQGOnqcFqHHGrrZRa5k7e3CNW2/eALVNQkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6126
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Liam,

On Sun, Feb 26, 2023 at 10:17:56PM -0500, Liam R. Howlett wrote:
> * kernel test robot <oliver.sang@intel.com> [230226 20:33]:
> >=20
> > Greeting,
> >=20
> > FYI, we noticed kernel_BUG_at_mm/filemap.c due to commit (built with gc=
c-11):
> >=20
> > commit: 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a ("mm/mmap: remove __vm=
a_adjust()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >=20
> > [test failed on linux-next/master 0222aa9800b25ff171d6dcabcabcd5c42c6ff=
c3f]
>=20
> If this is linux-next, shouldn't that mailing list be in the Cc list?

when this report was generated, the commit is already in mainline, so we do=
n't
add linux-next mailing list.

when our auto-bisect captured a mainline commit as first bad commit for one
issue, it will also check latest mainline and latest linux-next at that tim=
e to
confirm the issue still exists, otherwise, auto-bisect will regard the issu=
e
'has been fixed' then don't report.

above means the auto-bisect checked the "linux-next/master 0222aa9800b25", =
but
previously we won't list mainline check if there is already a linux-next ch=
eck.
Since this seems cause confusion, now we changed a bit about this.
as in a new report also to you
  [linus:master] [mm/mmap] 04241ffe3f: Kernel_panic-not_syncing:Fatal_excep=
tion
in
[1] https://lore.kernel.org/all/202303010946.d35666d1-oliver.sang@intel.com=
/
(I will also mention this report later)
you may notice that change. do you think that is better or do you have othe=
r
suggests? Thanks a lot!

>=20
> >=20
> > in testcase: trinity
> > version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
> > with following parameters:
> >=20
> > 	runtime: 300s
> > 	group: group-04
> >=20
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> >=20
> >=20
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2=
 -m 16G
> >=20
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >=20
> >=20
> > please be noted, as below table, parent also has other type issues, and=
 we
> > found they happen almost at same position of kernel_BUG_at_mm/filemap.c=
 for
> > this commit if looking into dmesg (attached two parent dmesgs as well)
>=20
> I don't understand what you are saying with the above paragraph.
>=20
> I thought I understood that the bug happens in the previous commits and
> there is a dmesg from the previous two parents attached.. but when I
> look at the attached two dmesg, they are from the same commit and
> neither has anything to do with filemap.

Let me clarify. they are really from same commit, i.e. 287051b185048c4a,
the parent of 0503ea8f5ba73eb3ab13a81c1ee

maybe from below table, it could be clearer.

for both 0503ea8f5ba73eb3ab13a81c1ee and its parent, we tested 20 times.
then on parent, we observed "dmesg.RIP:anon_vma_clone" 9 times, observed
"dmesg.RIP:dup_anon_vma" 11 times, so I attached two parent dmesgs to
demostrate each case.

for 0503ea8f5ba73eb3ab13a81c1ee, we never observed those 2 issues, instead,
"dmesg.kernel_BUG_at_mm/filemap.c" shows in 9 runs out of 20.

287051b185048c4a 0503ea8f5ba73eb3ab13a81c1ee
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          9:20         -45%            :20    dmesg.RIP:anon_vma_clone
         11:20         -55%            :20    dmesg.RIP:dup_anon_vma
           :20          45%           9:20    dmesg.kernel_BUG_at_mm/filema=
p.c


>=20
> And why would we blame the later commit for the same bug?

this is due to our auto-bisect could only use some simple logic. in this ca=
se,
it finds the dmesg.kernel_BUG_at_mm/filemap.c first occurs on 0503ea8f5b an=
d
not on parent, it has no knowledge if this issue is related with
RIP:anon_vma_clone or RIP:dup_anon_vma on parent (BTW, neither humans in ou=
r
team has), and this dmesg.kernel_BUG_at_mm/filemap.c still occcurs on lates=
t
linux-next/master and mainline, so it think it captured a real 'fbc'.
we have a manual check step for report, that's the reason you saw above
paragrah you said which is confusing.

>=20
> Did something go wrong with the bisection?
>=20
> >=20
> > we don't have knowledge if this commit fixes some problem in parent the=
n
> > run further until further issues, but since this commit touches
> > mm/filemap.c, we just made out this report FYI
>=20
> I changed one line in a comment in mm/filemap.c in the commit.
>=20
> -------------
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c915ded191f0..992554c18f1f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -97,7 +97,7 @@
>   *    ->i_pages lock           (__sync_single_inode)
>   *
>   *  ->i_mmap_rwsem
> - *    ->anon_vma.lock          (vma_adjust)
> + *    ->anon_vma.lock          (vma_merge)
>   *
>=20
> -----------
>=20
> Are you sure about this bisection?  I'm not saying it isn't my fault or
> looking to blame others, but I suspect we are indeed looking at the
> wrong commit here.


as above mentioned [1], now we made out a new report upon 04241ffe3f which =
seems
less confusing.

(BTW, a tricky thing is for report 04241ffe3f, the auto-bisect actually use=
s
"Kernel_panic-not_syncing:Fatal_exception" as the keyword to do bisection.
this "Kernel_panic-not_syncing:Fatal_exception" could be caused by both=20
(RIP:anon_vma_clone or RIP:dup_anon_vma) and kernel_BUG_at_mm/filemap.c.
if it uses RIP:anon_vma_clone or RIP:dup_anon_vma to do bisect, it will fai=
l
since starting from 0503ea8f5b, there is only kernel_BUG_at_mm/filemap.c,
so it will think issue disppear in latest maineline or linux-next/master)


>=20
> >=20
> > BTW, we also noticed there is a fix commit
> > 07dc4b1862035 (" mm/mremap: fix dup_anon_vma() in vma_merge() case 4")
> > by further testing, BUG_at_mm/filemap.c is still existing there.
> >=20
> > +---------------------------------------------+------------+-----------=
-+
> > |                                             | 287051b185 | 0503ea8f5b=
 |
> > +---------------------------------------------+------------+-----------=
-+
> > | BUG:kernel_NULL_pointer_dereference,address | 11         |           =
 |
> > | Oops:#[##]                                  | 11         |           =
 |
> > | RIP:dup_anon_vma                            | 11         |           =
 |
> > | Kernel_panic-not_syncing:Fatal_exception    | 20         | 9         =
 |
> > | canonical_address#:#[##]                    | 9          |           =
 |
> > | RIP:anon_vma_clone                          | 9          |           =
 |
> > | kernel_BUG_at_mm/filemap.c                  | 0          | 9         =
 |
> > | invalid_opcode:#[##]                        | 0          | 9         =
 |
> > | RIP:filemap_unaccount_folio                 | 0          | 9         =
 |
> > +---------------------------------------------+------------+-----------=
-+
> >=20
>=20
> At what commit did problems start showing up regardless of what the
> problem was?  I did not see any other emails from this bot since
> 2023-02-12, but clearly it is reporting problems with earlier commits
> considering the table above.
>=20
> >=20
> > If you fix the issue, kindly add following tag
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Link: https://lore.kernel.org/oe-lkp/202302252122.38b2139-oliver.sang=
@intel.com
> >=20
> >=20
> > [   28.065728][ T4983] ------------[ cut here ]------------
> > [   28.066480][ T4983] kernel BUG at mm/filemap.c:153!
> > [   28.067153][ T4983] invalid opcode: 0000 [#1] SMP PTI
> > [   28.067868][ T4983] CPU: 0 PID: 4983 Comm: trinity-c3 Not tainted 6.=
2.0-rc4-00443-g0503ea8f5ba7 #1
> > [   28.069001][ T4983] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> > [ 28.072145][ T4983] RIP: 0010:filemap_unaccount_folio (filemap.c:?)=20
> > [ 28.072927][ T4983] Code: 89 fb 0f ba e0 10 72 05 8b 46 30 eb 0a 8b 46=
 58 85 c0 7f 07 8b 46 54 85 c0 78 11 48 c7 c6 a0 aa 24 82 48 89 ef e8 0b d2=
 02 00 <0f> 0b 48 89 ef e8 01 e7 ff ff be 13 00 00 00 48 89 ef 41 89 c4 41
> ...
>=20
> > [ 28.087701][ T4983] __filemap_remove_folio (??:?)=20
> > [ 28.088418][ T4983] ? unmap_mapping_range_tree (memory.c:?)=20
> > [ 28.089168][ T4983] ? mapping_can_writeback+0x5/0xc=20
> > [ 28.089940][ T4983] filemap_remove_folio (??:?)=20
> > [ 28.090627][ T4983] truncate_inode_folio (??:?)=20
> > [ 28.091342][ T4983] shmem_undo_range (shmem.c:?)=20
> > [ 28.092036][ T4983] shmem_truncate_range (??:?)=20
> > [ 28.092753][ T4983] shmem_fallocate (shmem.c:?)=20
> > [ 28.093444][ T4983] vfs_fallocate (??:?)=20
> > [ 28.094128][ T4983] madvise_vma_behavior (madvise.c:?)=20
> > [ 28.094874][ T4983] do_madvise (??:?)=20
> > [ 28.095491][ T4983] __ia32_sys_madvise (??:?)=20
> > [ 28.096166][ T4983] do_int80_syscall_32 (??:?)=20
> > [ 28.096885][ T4983] entry_INT80_compat (??:?)=20
>=20
> What happened to your line numbers?  Didn't these show up before?  They
> did on 2023-02-06 [1]

oh, this is an issue under investigation now.
I guess the report for 04241ffe3f is kind of more valid?
I also mentioned this problem there and will update you after we fix.

>=20
> ...
> >=20
> > To reproduce:
> >=20
> >         # build kernel
> > 	cd linux
> > 	cp config-6.2.0-rc4-00443-g0503ea8f5ba7 .config
> > 	make HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Dx86_64 olddefconfig prepare mo=
dules_prepare bzImage modules
> > 	make HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Dx86_64 INSTALL_MOD_PATH=3D<mod=
-install-dir> modules_install
> > 	cd <mod-install-dir>
> > 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> >=20
> >=20
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-scrip=
t is attached in this email
> >=20
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >=20
>=20
> This does not work for me.  Since my last use of lkp it seems something
> was changed and now -watchdog is not recognized by my qemu and so my
> attempts to reproduce this are failing.  Is there a way to avoid using
> the -watchdog flag?  Running the command by hand fails as it seems some
> files are removed on exit?

this is really related with a deprecated option '-watchdog'. (as Matthew Wi=
lcox
also mentioned)

on my local platform:
$ qemu-system-x86_64 --version
QEMU emulator version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.6)
$ qemu-system-x86_64 -watchdog i6300esb
qemu-system-x86_64: -watchdog i6300esb: warning: -watchdog is deprecated; u=
se -device instead.

I guess you are using even newer version which deprecated this option alrea=
dy.
we've already pushed a fix:
https://github.com/intel/lkp-tests/commit/18c7a9c9fe0eebc4536220b97b10b47bf=
ae00595

>=20
> I did try to remove the directories and run from a clean state, but it
> still fails for me. (see below)
>=20
>=20
> Thanks,
> Liam
>=20
> 1. https://lore.kernel.org/linux-mm/202302062208.24d3e563-oliver.sang@int=
el.com/
>=20
> Log of failed lkp 68d76160fd7bb767c4a63e7709706b462c475e1b
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> x86_64
> =3D=3D> Making package: lkp-src 0-1 (Sun Feb 26 09:31:45 PM EST 2023)
> =3D=3D> Checking runtime dependencies...
> =3D=3D> Checking buildtime dependencies...
> =3D=3D> WARNING: Using existing $srcdir/ tree
> =3D=3D> Removing existing $pkgdir/ directory...
> =3D=3D> Starting build()...
> make: Entering directory '/home/jedix/lkp-tests/bin/event'
> klcc  -D_FORTIFY_SOURCE=3D2  -c -o wakeup.o wakeup.c
> klcc  -Wl,-O1,--sort-common,--as-needed,-z,relro -static -o wakeup wakeup=
.o
> rm -f wakeup.o
> strip wakeup
> make: Leaving directory '/home/jedix/lkp-tests/bin/event'
> =3D=3D> Entering fakeroot environment...
> x86_64
> =3D=3D> Starting package()...
> =3D=3D> Creating package "lkp-src"...
> 88466 blocks
> renamed '/home/jedix/.lkp/cache/lkp-x86_64.cgz.tmp' -> '/home/jedix/.lkp/=
cache/lkp-x86_64.cgz'
> =3D=3D> Leaving fakeroot environment.
> =3D=3D> Finished making: lkp-src 0-1 (Sun Feb 26 09:31:47 PM EST 2023)
> ~/lkp-tests
> 11 blocks
> result_root: /home/jedix/.lkp//result/trinity/group-04-300s/vm-snb/yocto-=
i386-minimal-20190520.cgz/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefb=
af51405385a/0
> downloading initrds ...
> use local modules: /home/jedix/.lkp/cache/modules.cgz
> /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 ht=
tps://download.01.org/0day-ci/lkp-qemu/osimage/yocto/yocto-i386-minimal-201=
90520.cgz -N -P /home/jedix/.lkp/cache/osimage/yocto
> 17916 blocks
> /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 ht=
tps://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-20180403.c=
gz/trinity-static-i386-x86_64-1c734c75-1_2020-01-06.cgz -N -P /home/jedix/.=
lkp/cache/osimage/pkg/debian-x86_64-20180403.cgz
> 43019 blocks
> exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev loca=
l,id=3Dtest_dev,path=3D/home/jedix/.lkp//result/trinity/group-04-300s/vm-sn=
b/yocto-i386-minimal-20190520.cgz/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a=
81c1eefbaf51405385a/0,security_model=3Dnone -device virtio-9p-pci,fsdev=3Dt=
est_dev,mount_tag=3D9p/virtfs_mount -kernel bzImage -append root=3D/dev/ram=
0 RESULT_ROOT=3D/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-201=
90520.cgz/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf51405385a/19 B=
OOT_IMAGE=3D/pkg/linux/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf5=
1405385a/vmlinuz-6.2.0-rc4-00443-g0503ea8f5ba7 branch=3Dlinus/master job=3D=
/lkp/jobs/scheduled/vm-meta-102/trinity-group-04-300s-yocto-i386-minimal-20=
190520.cgz-0503ea8f5ba73eb3ab13a81c1eefbaf51405385a-20230224-7240-hzx70n-16=
.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-kexec commit=3D0503ea8f5ba7=
3eb3ab13a81c1eefbaf51405385a initcall_debug nmi_watchdog=3D0 vmalloc=3D256M=
 initramfs_async=3D0 page_owner=3Don max_uptime=3D1200 LKP_LOCAL_RUN=3D1 se=
linux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_ti=
meout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=
=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 =
drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0=
 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw  ip=3Ddh=
cp result_service=3D9p/virtfs_mount -initrd /home/jedix/.lkp/cache/final_in=
itrd -smp 2 -m 3419M -no-reboot -watchdog i6300esb -rtc base=3Dlocaltime -d=
evice e1000,netdev=3Dnet0 -netdev user,id=3Dnet0 -display none -monitor nul=
l -serial stdio
> qemu-system-x86_64: -watchdog: invalid option
>=20
>=20
>=20
