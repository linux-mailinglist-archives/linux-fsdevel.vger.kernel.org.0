Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BEB4EE1B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 21:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiCaT37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 15:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbiCaT36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:29:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF661E1111
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 12:28:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VImYuC027098;
        Thu, 31 Mar 2022 19:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=J31Id8h48y5XOLjBNC6SGN7JhJNJuc1JBfWXGihxrBc=;
 b=rNOOaO5U0C01P06UgSx091RBDUJ6VuyXuKvtprgsQz0LR8MHM3Lt9jpmdfZKlgQ50yle
 ceDBkxuRVVZaw2VUT+LQ1nZvesrdvefttcQOHe5X93C7mTSUJxV7UgH72JutcO8Ca9Jh
 1WtQi83B1FG6vER6yavfvLSx8dyCScV2rqJxDNvxkwBc+uea8il7hh8zo2aHISW4BZw6
 KaXy0JrmAPVu+19ivYt0EAxvvrGWtIWgD99aOE3opsCRL/T4HJyNjh6H+mJFv+MTSci4
 9y4UgmISA5kJRKE04hh5w1QILFVvEydYHa0BnWxN/8Y4/F68XCpOq6qbAHPV64wDCSI+ /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cvxjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 19:27:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VJBN0U003699;
        Thu, 31 Mar 2022 19:27:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95smdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 19:27:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX6XsR7QtRX1RZevxin7+XTn1kqLMW0ioZgrqfkEHR88vXiCQ+r/oAbAITRq4D6kQGnyP4EWQekd2tFHvuiRwiHwbXcDHjC8YgrqqOQPKZfyS+w5XPkVkG7en9iT8mRykca35UfVVzyhD0VK1d2/J1JsiOTBMD31uzzb8rH23vQyF384iDieB96N6RY3r506GQPH7VGuozLnes0HUPvbeukOmcrm+gyLgUAadh4Resi/bIeYc6Z6B+9Gj38jMnzQTVGY2tUZw7IeVK0OWcc9dGpBXpw9Tpz9i2+Hx4VPviH8NrLxIdyQ4fmq0HpzCswweOg8ABxNhVTdglrGUeja1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J31Id8h48y5XOLjBNC6SGN7JhJNJuc1JBfWXGihxrBc=;
 b=TGAQG+H4g3GVSUUwhVWXFGWrWGE0IUHlqtoOZZ5fIuruQtFfw0y6efE2Y67cKTuILNpojRpkkp3KSWV/li6yTdbMJgJc+FYsIeikqL+lH3W9GLfKyfAPz1+aM1ITgmAWdH2+3ZhzeGw3RqTyuDfMmDjqJSwzcabjE0AJqn3QX5qmGWRwXCjdzeE3+gZp4Ucyh1ZvguBLAoQBcRxD8jHdI/QcZ7UKtMCxckbqWsXHtKteKXoWwR7ZNv33nzW4BMEh2OWx+pyHauJy8zHwQF9tgUrLvhSwgdwujaC0hjPvcyIRBWGoH0BBrGAEb1jWAz8EZFtFxk/rQTjyUzfubMDCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J31Id8h48y5XOLjBNC6SGN7JhJNJuc1JBfWXGihxrBc=;
 b=CCexIrPdVFDc+6Ihcjs/iPC6kZTHlOFSgqR+3Ms0RL7nJ3RDbJGCwPdmvreMo4MbXiXXyh4E+nAr7RbPWzluTQwbicWfIiFdeE5nKhjttdY4LF2SwBOZS+E9nh5ACQxshrr5FhFptutmEBSU/jtIR1iR33T7dzd8UVyo3fkf/LM=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4278.namprd10.prod.outlook.com (2603:10b6:610:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 19:27:55 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::9ca1:a713:90c3:b5b3]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::9ca1:a713:90c3:b5b3%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 19:27:55 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
In-Reply-To: <f849f7f981ef76b30b4d91457752b3740b1f6d51.camel@HansenPartnership.com>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
 <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
 <20220316025223.GR661808@dread.disaster.area>
 <YjnmcaHhE1F2oTcH@casper.infradead.org>
 <a8f6ea9ec9b8f4d9b48e97fe1236f80b62b76dc1.camel@HansenPartnership.com>
 <42d92c6f-28f2-459b-bc2a-13dd655dd4ae@www.fastmail.com>
 <YjozgfjcNLXIQKhG@casper.infradead.org>
 <3a7abaca-e20f-ad59-f6f0-caedd8450f9f@oracle.com>
 <f849f7f981ef76b30b4d91457752b3740b1f6d51.camel@HansenPartnership.com>
Date:   Thu, 31 Mar 2022 12:27:53 -0700
Message-ID: <87o81l6hxi.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0006.namprd04.prod.outlook.com
 (2603:10b6:803:21::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39096568-5f3e-4db1-5196-08da134c8e2f
X-MS-TrafficTypeDiagnostic: CH2PR10MB4278:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4278DEBD80952121FA281709DBE19@CH2PR10MB4278.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsAIeuOM46Gt+UY3H4YW8BIKLJqSnGAjq0m/oGy79qGvyp+RVXMcEzR22zGNY81MVAiIErD5kion5dYeYpj94nQXW5d6ZYcBLtyOkm7CqzeZ+oEfaJFiQ7mDs/W0Ekrtcdc9wMGzeadiZDXXyqfPSHrAPuzJEbt1QN3Ow0BK6usOWSDiW36Cp9OSVJzygGygsq6OpPow8iSWOKAuBVy3WbRXjfBgedz93VrDAXbob2YfXWMY7G9+pW++bT5/jv97GCZ2R5PZ8eFzT7cLhQKPOU0w6WJ3jBBb8jBrUJxDRoXAgeF/r7EgrK5y+0TxmJy54J7Lod3BW+bQ1TYJJOIoYm/sVQO1jGgKYvkCLIqjivD3PdvY3fff2QnAAISDS4qwySEalXPpoZROqG+JdbZkC0F/qPLhyDtt7CMN6DcnsJaNa4EQIKzzzzRQwgEiqomFqz+bg3I5nWet78W95eaPIvZoEIYWd8vUePaJ4rh+xbwvPIi2FfRaAjhGziXA0zLn6yp9fIauNvXGPGKbV78S9bI9/WRryZp1HRwekB/UnUWsrVKjFtSZlsn4J9RkAApk1JSuHbsLB7pwQRj0O6Ag6Ji2k4hZAjUkZX/09fBaxWa4VGVd3+TgqCugVszQjIJo5j9Sc3ykTMAztWLleUceU5peZMjykD6khMgBVn8Hk+NZjpGG63orsC70pVb/8itQsz2oq3BOclyWMVueLZ59kWQiG2xmjP+mQ3Ah1S6A4vKRS0gJwANoD745q2gecypIrYg8kfJRaZ3BUJI2BJnsaTSWDTKcvy2MHhKtIIAxfrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38350700002)(38100700002)(6486002)(508600001)(966005)(5660300002)(186003)(26005)(2906002)(8936002)(86362001)(110136005)(316002)(54906003)(6512007)(8676002)(6506007)(52116002)(66556008)(4326008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LUDbCFhZIR3wKOTO/V2PalvRZbXE9sITEC9Xa3Y+zYG6aovgloZqQFODWLMu?=
 =?us-ascii?Q?iJ3cN5l2nPOpgY2oSEIWKiQvybI8PW07BM02N5KAl2fr7GY5xiLpc6spdTtW?=
 =?us-ascii?Q?8N506RKDZhLV6KllHwlNhUVOMZE/JtALvWjj2vyFhrWVEHmu78pufYs2L5Ix?=
 =?us-ascii?Q?YpnsGfBZHcWUvgvZ0fDsawXlj/3EGwq+RkR3XtIXJ2NY+EIw8uloY/LfqMa5?=
 =?us-ascii?Q?6YGLeMU+LfXbcqf9ECZ8tx5xyxrSBie8E1bn2AIgSQ4NtYEm+wmDAtkKUocJ?=
 =?us-ascii?Q?GvJip/eSYcaiO4joagwPmP+WjjoxxcyB+l59hEtwiY3buUKRtXXGb88Kj+tV?=
 =?us-ascii?Q?XoYwGs9sL29Zn9qPbqQE1hYae1CfaaElUUdxQ46xHjNmlBAIdpC1EShTRfwQ?=
 =?us-ascii?Q?SFbZCw3oz+7qkylHK57itLSXKFaPxGiSkB/kYAU6Og6Wx/NwAJjtQrcQs3xG?=
 =?us-ascii?Q?aa2mGsYWVgiqMWNCqp/cTVvW7MNxjEFul1uJsAcllDBOMz1fK/+cbh913BwU?=
 =?us-ascii?Q?FsMlcp1uBdkoQvUj8iDaR+fi3tMZRKy0YplJ/jXaXILwn+A6wS/9VicMjH36?=
 =?us-ascii?Q?Yg+F9/pSNzzehdXgu++vLWqGw/QVU3q1zdoopWavDJdckjenmxSK74gNPOHO?=
 =?us-ascii?Q?1KmPIrWkKsCFl5AaPUl3/5byXVZc+WdWzULXR99j45sAOXTA18rglGkEkMD/?=
 =?us-ascii?Q?K8Ool7jt1VOD8JjxGr/zIlzxtthySJk28qtNIhtuoy55Sdbi5eJuyJF2T8vu?=
 =?us-ascii?Q?5eZ0vD7TzqERHf1XMKuNXJxA8rnumfKqCyTHNkYbGk1cLLb7EB8bmAKSeXpB?=
 =?us-ascii?Q?o67+LDjYZKgK0xuneqlteqQyZUs7OxuiR9RXs/TOkuAhVSrJGs7ODfDv1G0U?=
 =?us-ascii?Q?0CdwR4FjRCm3R52iwKZrb+QO5KgbprK4j85Z/hS8YIzGj1AlgQyUNdXjTkwM?=
 =?us-ascii?Q?Bhsn6xJMFD37Q2xGSkRIdSmfSiI8vRTwm8NDLVFOFypLh6hUsr6daPNiCFsI?=
 =?us-ascii?Q?u5BcVgUvbLVsj02yYkQGyhQ8Y32J7H26zyNloY+QFPVOH3N8kQcZaiO7OGBm?=
 =?us-ascii?Q?F2v8CqnyNpe4IAW/C/QbWgE+tVAwKj5BAXmGhEqBM4yx7xqXer3r2l05neWZ?=
 =?us-ascii?Q?6qryKFq5W+jHtxuNVSkXggBaQICCBxofRVBOFBqKq4kx1snXjNnkWFqDcM6a?=
 =?us-ascii?Q?oMbfG0RW4CAFcVhM7BNnbt5kZwXGecUdGlrhzdkRj7zWW4NHsiUaLHkosjqG?=
 =?us-ascii?Q?0fh4ef6swO4N5o+Gw9G86xkj0EpKXK/yIX50tb04OfPNRaQpVVVw+ofxnpcC?=
 =?us-ascii?Q?SrrTtyS8M/bFYW3AzVD5TB9d5HG83OEdQgXmaaaTTjilHAW3dgOubvuXfQqI?=
 =?us-ascii?Q?FD1XiW2yUFigTuelOdw5lTGnbaMQFVv7p6dHoP6W0I7ZYsXaavTkzbedMmbM?=
 =?us-ascii?Q?mE6PbfOHqkwYI3lcbJWTpyp+HTjkKKUpuh9Xvd5j5MCRBK1QcC/Pe7yD4L1Y?=
 =?us-ascii?Q?qCS8aKBwl2w11L25GCFYtuWub9Nf7qXm6dK3OF7eqadNZ8FNZ3HBrfQI4gpf?=
 =?us-ascii?Q?p4kCbgO94nl28Xssg/Jn/UCXghmuzRiL1ARDA1PGXP1b+eL3fhq6was9K+In?=
 =?us-ascii?Q?rGQJbRdvqVLBxXVYbTR7GnyVaLxSKjBc5ETTFl2NsW8XyM7aUZSlzVMba68r?=
 =?us-ascii?Q?KDmcv4fiGEvOL8Z6pD2u6+ZYUrKMPwIOpG+jhMADtF3zH9ALaSCKd70wk3Zd?=
 =?us-ascii?Q?9dAyWdqoIg7MUs5qctqy0rg/IW3EW/ur2u3j9JdQ9dldpjy/Pcw6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39096568-5f3e-4db1-5196-08da134c8e2f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 19:27:55.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1Uu3hqtoq5dHJQ18mqEY8+Mqa9WmJJzjh+cOQQkf7saatvBuFIN64dAuaWJ83TlEFwPhP6AtRhj8yKmW/XQrcZFDo3l0y6tTRIqkulCrUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4278
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_06:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310102
X-Proofpoint-GUID: NIBVr4teLyGWTM_rRMSAB1BOQVXhyieq
X-Proofpoint-ORIG-GUID: NIBVr4teLyGWTM_rRMSAB1BOQVXhyieq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> On Tue, 2022-03-22 at 14:08 -0700, Stephen Brennan wrote:
[snip]
>> If we're looking at issues like [1], then the amount needs to be on a
>> per-directory basis, and maybe roughly based on CPU speed. For other
>> priorities or failure modes, then the policy would need to be
>> completely different. Ideally a solution could work for almost all
>> scenarios, but failing that, maybe it is worth allowing policy to be
>> set by administrators via sysctl or even a BPF?
>
> Looking at [1], you're really trying to contain the parent's child list
> from exploding with negative dentries.  Looking through the patch, it
> still strikes me that dentry_kill/retain_dentry is still a better
> place, because if a negative dentry comes back there, it's unlikely to
> become positive (well, fstat followed by create would be the counter
> example, but it would partly be the app's fault for not doing
> open(O_CREAT)).

I actually like the idea of doing the pruning during d_alloc().
Basically, if you're creating dentries, you should also be working on
the cache management for them.

> If we have the signal for reuse of negative dentry from the cache,
> which would be a fast lookup, we know a newly created negative dentry
> already had a slow lookup, so we can do more processing without
> necessarily slowing down the workload too much.  In particular, we
> could just iterate over the parent's children of this negative dentry
> and start pruning if there are too many (too many being a relative
> term, but I think something like 2x-10x the max positive entries
> wouldn't be such a bad heuristic).

I agree that, on a per-directory basis, 2-10x feels right, though maybe
there needs to be some leeway for empty directories?

Per-directory pruning also makes sense from a concurrency standpoint:
the LRU locks could become a source of contention.

> Assuming we don't allow the
> parent's list to contain too many negative dentries, we might not need
> the sweep negative logic because the list wouldn't be allowed to grow
> overly large.

Seconded, I have no desire to actually try to get that sweep negative
logic merged if we can do a better job handling the dentries in the
first place.

> I think a second heuristic would be prune at least two
> negative dentries from the end of the sb lru list if they've never been
> used for a lookup and were created more than a specified time ago
> (problem is what, but I bet a minute wouldn't be unreasonable).
>
> Obviously, while I think it would work for some of the negative dentry
> induced issues, the above is very heuristic in tuning and won't help
> with any of the other object issues in filesystems.  But on the other
> hand, negative dentries are special in that if they're never used to
> cache an -ENOENT and they never go positive, they're just a waste of
> space.

I took a preliminary stab at some of these ideas in this series:

https://lore.kernel.org/linux-fsdevel/20220331190827.48241-1-stephen.s.brennan@oracle.com/

It doesn't handle pruning from the sb LRU list, nor does it have a good
way to decide which dentry to kill. But it's pretty stable and simple,
and I value that part :) . It still needs some work but I'd welcome
feedback from folks interested in this discussion.

Stephen

>
> James
