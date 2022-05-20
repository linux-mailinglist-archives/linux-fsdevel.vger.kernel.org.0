Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4B52E2F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbiETDQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345098AbiETDQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:16:26 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6694C4E3BB;
        Thu, 19 May 2022 20:16:23 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K2oalb022296;
        Thu, 19 May 2022 20:16:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=PPS06212021;
 bh=HZfF4uC4Ug6qi3BSF9O/TKzXNBLtVClXF4ZVHDUtmRI=;
 b=ps+eAAQuFJX8cNVNt3SWWZnQqRirFHZA/46ysjZJlcGWZpTK/HYt47VF6XVcVxunLCx6
 OaR6Z+vsXtfYaLPQfJVwjy1okc+5sU+HUsUQnl5PAhvTtBA7jDbpx6yB8e1uv4FHtkFJ
 39c2q89z1umJTAFNSq9HcAV14lPa6Ruar+IyLuGDDKc5/ar2EV8V5nrPes7jwDzQXDI1
 qo1y9o7KmmtI9vb72UejotIlsnR9SAIiJQBRxKqaEYAGQEqb1ClSIioNcJ4BSBDr4tRv
 2UaGbyPB/uu+KmPl1SL6er6n+Yy9uIWp70Z3R1R0Ql6rsrYg4jMgbi8Xdg5zyQXgVHEP KQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3g27q4vskf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 20:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1YTw3E1JNUPVK4TCxml+GrVnydZADTMWMD3bp9gO0W8sMtUd4cHEFSzR5wv9KVE58zTasaYY8i7BseWUAGUnxskDqukwNVNqsXrUr9QPyC2+lzo69cBoOGUr8xoeKXxFnt/fVyU85c85AjWnmmm1yhVH7Rdl5qIjRWRSqIYyiOJCsJY9wRynvzUkWiJ8XqWlSN4phx0JqBbIWqPI/whS+rChuZuP782XtSANfibFdI8FDOix4C+Fbv2oi/7qaQYDkPUX9WZ3y2MQxmJVnHDscMotZQhM0Fqb8goSeEDgasxEW422I36b2/Oia7/WL5V56pZQ0kAGcLKT+TFHzWKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNPUIkkGtHUksmrV31XNgRQQ3K6hLsNLE7d60wJETIs=;
 b=EOIAWtYwCqNfUQndxnGvSPpFQJkqyTBIBD4GQtC5TNKKwrN1Tl5af2zTncdZwpYfi8XgoPPL6ceCM4qOUtUmqrYuXwqcDYapE/I+B5TMnBthe0a+CIp067yMgiVhhvRHBFE0I4NkL/vxoArHBr+B7YNg7Eolex+hmMQDC32/8Ewy9idVQH2IRt847xgXxGl6eIgKjm5KFmANVIjU/BnkgfGMETUgEfME5F+2II+SusejT/GH3l9OBRqenrYv451OVbgIbX9EC1Iokx6sPvYDcFe68aaEo7JFN7bjha+qWiJ9pbiD1tn05fu2amEDoig9/KsRYiIc83s4QGQ3KSzl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by MWHPR1101MB2317.namprd11.prod.outlook.com (2603:10b6:301:5b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 03:16:08 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 03:16:08 +0000
Date:   Thu, 19 May 2022 23:16:03 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Amir Goldstein <amir73il@gmail.com>, He Zhe <zhe.he@windriver.com>,
        Dave Chinner <dchinner@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>
Subject: Re: warning for EOPNOTSUPP vfs_copy_file_range
Message-ID: <20220520031603.GA54241@windriver.com>
References: <20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com>
 <CAOQ4uxiQTwEh3ry8_8UMFuPPBjwA+pb8RLLuG=93c9hYtDqg8g@mail.gmail.com>
 <87czg94msb.fsf@brahms.olymp>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czg94msb.fsf@brahms.olymp>
X-ClientProxiedBy: YQBPR0101CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::9) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870ecef2-fb53-4494-d0e9-08da3a0f1533
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2317:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1101MB23173B84F9B74A49ADE5D17083D39@MWHPR1101MB2317.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUyaPSh2qfZvAVH2yNuo1LbCAcqo9SycnWkXj5sERvrWI3/ntQARtFthoevd4WUGxe2NLpjj2qSdZAdyGbCh1rsBpQ4bRbZYcuaZ3a0EyRIWGEfJyxe3vH/xf2iffj/gqDvJ8oSd5B73l5p/vs9B3cWSbt1U9y/0YKvqBvs8FsI6E4cB/Uz2bnEYEfH0owozakkhV9JVtAF1G6UimCfdNrf3t8lq7vIRMzdfcWTNoMP/WJf42Y6AQ8g+6pcOXmMGi5PvyAvmttkKUjXUu+wDMfRdXyFP2EJ3jD37tSls5CL0AXHUTOQbm+PEpuGloY1F2O+LTkVyCvQEBHIsj18oecPufnXbeNLmR19NSy4M75+SQmZ6RsWTWK5/WpMaP6sAP3E2BSwW6UPG98zcTUAW8/HlaYueFU3adh5brIgqQ74rNGmyd6wQXzOCmHrf0gBEYhQJEP7YvEspn89Moo7zP55OOsTqt757w3zYSqSxuixICJYlM1DlH7tBXvMxMz6pdT+7TOAPf1iY6sYzwTo1/9vI/9CuhOLYS4fjG1EB7sX9BN76aQP1qzvFGWLBTLVJ3fmjMzENPFSBVDBqG4QpOShtE1N1ELdRJojFWbjbM0t83At4+Q20FT6Vw1Y1u9pU8TK51l/wJyAgMVkUEjEz0QDmGCNpukmZ1fcpaWm2KyHayA3JNwUVCzn7hvO012scJIH+VA9wNGNXY6ucLEid4fFWi96m2whAj3Mno12ZTXK6aGaV4Iyn8+2/6Y4vsJ6W+ElOBaCcidDmt/gg1pv2E6dRKxeSZ56ZxqCqKWSOBqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(26005)(6512007)(38350700002)(38100700002)(53546011)(6506007)(66574015)(86362001)(83380400001)(8676002)(4326008)(66476007)(66946007)(66556008)(2616005)(508600001)(36756003)(966005)(5660300002)(316002)(54906003)(6916009)(1076003)(2906002)(186003)(52116002)(8936002)(44832011)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vnwHedmpCChD/HsNdLYaM2GiVUyPchS6caOYxWtssIKcLEaIhARUhf2hG8?=
 =?iso-8859-1?Q?pKDQVWDEL0qNeeWBxnO+YnpmU92kk9zlCKA5Yju5T1DeBtFfWfYRkWriq4?=
 =?iso-8859-1?Q?K3nw6SM+lNC5EspsxozmQAWlqrAXY4zcbeqM2qOUXkko9qIZ7lPu6KbBEk?=
 =?iso-8859-1?Q?xCJCtSmQM7V9KowFdChaXgFn1XxCM6bguOmBEgX47kxRg+3MrU31NkWV2v?=
 =?iso-8859-1?Q?ffFRcPgIUaubwM+qeQvNAGYL6A1DB3h7IT7nsOSledpMAlnbUVnu9UZ8zD?=
 =?iso-8859-1?Q?yhaPEg/dJhHJnwcPnNobBz6K0kZGep5TN5iB3JjIWKoGhU1PuzJKQPx52V?=
 =?iso-8859-1?Q?14+IuldF92c4kaoQSn1Smcs3Ac8MH9mrXJMIZiuhuoDgEeWvw/er511f+I?=
 =?iso-8859-1?Q?c0HScKxFwo6afYn4QZIn9F9Uxqdnpav7LWieOoQNPHu7A32qjDQxAv1QKc?=
 =?iso-8859-1?Q?DOd5KxvSP1GvByP6apNO40GgDTHESSuJiQo/STj9hYWOEeGeUpqkhGzqAy?=
 =?iso-8859-1?Q?Xx5zsWT4hkqF5fuVRxxHXSTzfS+GKOrmtAGZjOl5ZHaWV8MP/DeKeMZ1P1?=
 =?iso-8859-1?Q?m/1OT1zbKDeweuqtKR/rq4iQftq1T8hi3fjl0ADrYUKFF4Rkrha+BLrglJ?=
 =?iso-8859-1?Q?mLJ4BXketxIWeLnlCsGUYqbupHIteYaWliAQZ7VwhSARuWZG31pGltYD31?=
 =?iso-8859-1?Q?4FPmXZ5gN4r4cb9nPHAvcWbcXbuEbnIq/0O/euuQfW7xNT432hIPIaFZ32?=
 =?iso-8859-1?Q?WMq8SMS2B4iWPEVepL9qf0NYYF800SP/bvFKKvrcp8dK9tbGyU1P6kv2Vt?=
 =?iso-8859-1?Q?NnfCQkjmtySTLgYgAiVLUpWvHOzhME72nHEhPmBBoQIR+67WX6Vqxso17c?=
 =?iso-8859-1?Q?rnwIh4yIx7qZYe5I/FaBRdIcf/gfgAOquZ8J5mMuAK7/Ye9eQrQ6l5iD9w?=
 =?iso-8859-1?Q?9Yh64oOH6ad5W/Etn3rSJ3eahgrGUKGTf17Lg9y2ju5w3zL+2T6ZoobxG1?=
 =?iso-8859-1?Q?UlOLaOOqHzIEpx7hsO3ivUDJ32ROuDR7euoQ8Z8RJkFPGoPdigoX3unuYA?=
 =?iso-8859-1?Q?tVX2xMSW/eyzNnmFa5asG7T+DVAnjHbAmPhK2/c4AXVEEdI7aftrBZPpkC?=
 =?iso-8859-1?Q?Lcxm/oCe6dUzJ+rHH/FUSojOQJ2Dcu5iGKP3cSfE45feLjcP0BmCbM4KNG?=
 =?iso-8859-1?Q?8Rn1bMsc6pN7H04gKz3Ytw5aGd9yNLki8UamEh0ZZZvo8I7H5VuM25jRNA?=
 =?iso-8859-1?Q?+8VQOk9Wf5JutOWf1RzyBRY2EJsUmnypwCCA0Gj45GJpyRRtzxoOTeu1S+?=
 =?iso-8859-1?Q?t6k3BcgQoAIEpJ0uZUJ8hynK5a7g+WGHgbYYm8JUgUbKpjB3TmdxSlzmsF?=
 =?iso-8859-1?Q?NvWWqjzsvVldrgqQ0v00n4mIgdxJw1kRiGOkqgiwhpIlmvN3SMP3gIuwnF?=
 =?iso-8859-1?Q?wKLSm4PueajWkfQ9fP3VbFHWnkzfZN+LE27n5Wa1LCmhD3T6PQtStN8liP?=
 =?iso-8859-1?Q?xB8z1aAtUqmZbkC011zKlDSiuIZgzVnQTzg6h8dQZ3UWMotDa1JZ5mOlBp?=
 =?iso-8859-1?Q?6LDXn8octO4zvoPeJvlp+NNAeURNJmKykci4iqya8AnYP4opDGh4RbHq2t?=
 =?iso-8859-1?Q?FeYz1undeM5Y/tTU4ohDmNG5TL7SbdReE1HmZnws20Cbe91P5am8wuY3TA?=
 =?iso-8859-1?Q?D3a/bBHnn7uv9rkZcennh4dUyYeAmSa7aj55lSlxpLGTYatKvjDP20UBvp?=
 =?iso-8859-1?Q?R4PdVBil5ZvfG49cKgTTIthwCWr7jmWVXh9vXtZquh/Fn84sZm80Dq5/1L?=
 =?iso-8859-1?Q?V7yDWZokO1AJc6z17FzXbfE1L0WVNsA=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870ecef2-fb53-4494-d0e9-08da3a0f1533
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 03:16:08.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzfTT/B+vgzDJ3S0LpUt0WUml37sMCPEnt1dNyLkFB2vxo1ETjEf0nAt5Fb4cdLKqNbNIqGF37lUVWq95w7xQcYzP6aMfhn7IXClKCkCap4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2317
X-Proofpoint-ORIG-GUID: WK9X_Qs_n1WBa4umGLU_mz2JVlTkxVPQ
X-Proofpoint-GUID: WK9X_Qs_n1WBa4umGLU_mz2JVlTkxVPQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_01,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 mlxlogscore=865 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Re: warning for EOPNOTSUPP vfs_copy_file_range] On 19/05/2022 (Thu 15:31) Luís Henriques wrote:

> Amir Goldstein <amir73il@gmail.com> writes:
> 
> > On Thu, May 19, 2022 at 11:22 AM He Zhe <zhe.he@windriver.com> wrote:
> >>
> >> Hi,
> >>
> >> We are experiencing the following warning from
> >> "WARN_ON_ONCE(ret == -EOPNOTSUPP);" in vfs_copy_file_range, from
> >> 64bf5ff58dff ("vfs: no fallback for ->copy_file_range")
> >>
> >> # cat /sys/class/net/can0/phys_switch_id
> >>
> >> WARNING: CPU: 7 PID: 673 at fs/read_write.c:1516 vfs_copy_file_range+0x380/0x440

[...]

> > Sigh! Those filesystems have no business doing copy_file_range()
> >
> > Here is a patch that Luis has been trying to push last year
> > to fix a problem with copy_file_range() from tracefs:
> >
> > https://lore.kernel.org/linux-fsdevel/20210702090012.28458-1-lhenriques@suse.de/
> 
> Yikes!  It's been a while and I completely forgot about it.  I can
> definitely try to respin this patch if someone's interested in picking
> it.  I'll have to go re-read everything again and see what's missing and
> what has changed in between.

If it helps any, you don't need CAN bus or anything complicated.  I was
able to reproduce it with the loopback device on linux-next of today
with a new userspace (from Yocto) that actively uses copy_file_range()

Note that a cp or redirect is needed to trigger the copy - with the
new userspace requiremet.  Or write your own reproducer that goes at the
syscall directly on an old userspace (untested by me).

  root@qemux86-64:/sys/class/net/lo# cat phys_switch_id
  cat: phys_switch_id: Operation not supported
  root@qemux86-64:/sys/class/net/lo# cat phys_switch_id > /tmp/foo
  [   87.527506] ------------[ cut here ]------------
  [   87.527675] WARNING: CPU: 2 PID: 238 at /home/paul/git/linux-head/fs/read_write.c:1511 vfs_copy_file_range+0x47c/0x4e0
  
Paul.
--

> 
> Cheers,
> -- 
> Luís
> 
> > Luis gave up on it, because no maintainer stepped up to take
> > the patch, but I think that is the right way to go.
> >
> > Maybe this bug report can raise awareness to that old patch.
> >
> > Al, could you have a look?
> >
> > Thanks,
> > Amir.
> >
