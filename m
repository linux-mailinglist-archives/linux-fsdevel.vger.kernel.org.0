Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD00960E70C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 20:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiJZSON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 14:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiJZSOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:14:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23351AD98D
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 11:14:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QGUQEb001643;
        Wed, 26 Oct 2022 18:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ENoHJQqp/bVhmptqEXuf5WeQ7JEKYLeQEAVg8x81Y+8=;
 b=vFTsS8pvFTqKjpIkeyZzs8YEPVi+bdTPm4qhDQRlM7BNjMm1MsC0UK4zijGlBnFjWY6D
 nfzp1RSr6VnbO1e2XOygSEx21uLQ1mcKh4N3EwqGNcQLZ4jue8vq66kznEbc+XFBdx1+
 +x4vhYXRj3y/1ALZ3VXfUlSgsx7CS8+sEXzcxn6WKhLKGrvnJmOaGVZVIRrTU+yRldOL
 hR8sbA98ORvOkbhgKG9EOBcMvi4Yf4TXobQWTQcEOd+80Z5OSO59K5z8hAMkL8ye7DjP
 mJ0Q339MZ3gkkrvJyp1vaoGyiU/gXXt+s5zL4WHwNdUaWWIzZ5seA8AEI4Jw9LykRTb+ WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xe6pw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 18:11:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QH9R1C025656;
        Wed, 26 Oct 2022 18:11:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y5r4ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 18:11:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPAavFbSZ4PSa2hJxUZ18khtiv4V47MWuKgf0BZmELp/CjcroVL4P0aaGm8jGubN+xqb84/jVaz+90Mgj6DlzkcmOZtmeLlueRm7YoxY1JHHL1m2ueZg3FvxF/CqcUzWxwo1RO8iTXwG71/PTMqz/9PhVS/NqNfe515Df//qjqTUCC/xxC2PcIRtqLpcluAWbtt0KzlK2XeH23kZlW0/6BsMLkcQ37UGBPRiNbW6E47lUtdAURYyiXzIC0gazNSY+/mvWpdzeF96K1y1ylAyn3VaN3r+kz2AVFO0uonBGLL0/P0OpmnpTeEn9hGxYXQYn6pHmpzco4MknJXm+/39Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENoHJQqp/bVhmptqEXuf5WeQ7JEKYLeQEAVg8x81Y+8=;
 b=En9XWo47cbIYFR+Ugep4aEzys89AQxb3r/lH/Tm4pZ/bgThP/tcXFhWHcNoY0W0J9Rm3G7uqZ8BmwcY7CqGXBc5dzqvMOxI4ysm5pKYVpELNWmAC9GNY9gx8d4cXABH2CdMuyy8BlS5uujIERsPBAe2Ycm80jsPvvboiM3W6UZpzPM9b0o81QTfTIyYUb4O0QYGSLdl+9RB6lGC1L8gRntgePw1gP5MVzJdpKIfr4ykwvoyWQQzcANlt5Af4u2osrVZmPW0bP7cFS4FSHkZEGn9BCCoRy9FNSzx6eW/55mIsiPMxnYq1mYAAWWvk5m7jNFJSV4nlDzzjPA6fGrPTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENoHJQqp/bVhmptqEXuf5WeQ7JEKYLeQEAVg8x81Y+8=;
 b=JVmq+DWtIutsJ9Q6aFnb/pGdAUxjYOCFvSqRB/p81YqymafybETEMc98alwuhBeSFBzgfpR4A8QAKLfzKshECR9SawkinkuwqwNlhHXYxNrZ2QFcviNt/vMQ5iMCwnPtgDK+5Mx4lJ9X3K7RWEKirDHq54LNPvVOlBiYLTLJv8E=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.22; Wed, 26 Oct
 2022 18:11:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 18:11:32 +0000
Date:   Wed, 26 Oct 2022 11:11:14 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-mm@kvack.org,
        akpm@linux-foundation.org, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] fs/hugetlb: Fix UBSAN warning reported on hugetlb
Message-ID: <Y1l4Qr33LmTzvrhp@monkey>
References: <20220908072659.259324-1-aneesh.kumar@linux.ibm.com>
 <YxoeFUW5HFP/3/s1@casper.infradead.org>
 <6e8246ae-c420-df00-c1d1-03c49c0ab1f1@linux.ibm.com>
 <Y1lJNepa22oMZ3tR@cathedrallabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1lJNepa22oMZ3tR@cathedrallabs.org>
X-ClientProxiedBy: MW4PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:303:b6::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN4PR10MB5590:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ad250d-7bcf-41f4-d073-08dab77d822f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DA3CmtZZJLb82OkTuyTNjUGPC7q1OZE4GoBdyU/hIQsAHt7qt8wveWPtTh0nwpOVlkE6J5a0VIj9X8leSGqWRwVvCfYmZoIbvL7uZ918RxCkUuqkzjq+ze7NCd/eS9k1ItHN2QETkK7i3pFnmpoPbNeUzDwbuUZiPfmjak7NpTdpdEmuqFgZIa071swIVZ7jxy0t7nOklg5HpktVr+2xgIdYxF7ZKIJE0lOtFZE7EwpHt82m7ZsEtNdYUGkXja7Ae+BArWJwqf6V63efr2rAyfyErieqfXVBynM1LqS+xaMNcw37Cl3ufFZlHMrWzBBNS/N5/RgvAHLw2FWcOOFiJxZ87/zcDHlpItEGNxPES8QleABubP6WliYTJ0D7ghwgGbe6vFXwWhg5OmQEUao+4cieTAz0Zl5cZdUwlbmlQM+kPIgFCM2tWhkDoR3hslLQCajrEf38ItePQATapxfy+L1Z1cBwKogBa+yux3CAVSo6qw72SOoVnSfgOcWV+airDOCCQgYGWlXUZkuKqXS1H0bxAKTXIwlEmPcA7lZA8lnNys2sD9ZRybx0O6fmQSnXrdWBf7fy8rL+OsovIQuRHe06k+/wQtJBp03G1jz3X50vZGiHdt7IMUl+DZUy/WZpsSmPsdDgFyziFWnue5vpw4bxW2c/KRBb/xBM+lChLgO5sm9vBS3OF8PnmPn4IABxCOz6dt8uHh5yVGnHyV7Bgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(6666004)(86362001)(38100700002)(6486002)(2906002)(44832011)(8676002)(478600001)(4326008)(5660300002)(66476007)(6916009)(66556008)(8936002)(7416002)(54906003)(66946007)(316002)(53546011)(33716001)(83380400001)(26005)(9686003)(6512007)(41300700001)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JuQknefroofoaWv/nWNpImPUNMGmAe9Z4xPXLbHVuaL6GyBRcKfXAM5dAZu8?=
 =?us-ascii?Q?29XVfjOkK4K7efPx4i5qa9w0xroaOesSIHP1c5e0UdjUGRntZJ7yq/rt8vDY?=
 =?us-ascii?Q?Ci2qLq7vGxZvqbtzmGEooajuHMqv59pN2Mg0hXyOxAVDHTxlftP1BuxzsOdB?=
 =?us-ascii?Q?n36OmASs957l9dLLstpXkXx8M1CC02fm+Eh6L/x+XJZH2Es+s6tkcQhUYNuI?=
 =?us-ascii?Q?SwoEX/FIAbiijcGl+7IGoM1OP3Z0of0GrHTwApDk/HqMc7IZpHuaTKJoaoqu?=
 =?us-ascii?Q?wBcgsGwaPNhGzyfBJ4qYNlUQL87M9395dmRMnMu/mAozmrk3PDgR5diJkaAV?=
 =?us-ascii?Q?OPxOR0DrCf3dKXe5sPgxIhT4SvmxCgBm5vU2lVGQTM6cbNwSUFyNQbF52OFS?=
 =?us-ascii?Q?znhHq8AX94W6nmo2KQXww9tznbwS2VpvTeHO3AdevOxB9JBda+F3SB0bokKh?=
 =?us-ascii?Q?zf6CS8jeJHqIaStwlog9oZNk7CJvbSlNu4J0R2J3NvAMq0HDSKvWoY/jHqEA?=
 =?us-ascii?Q?hcTJ1EYkAu+CeVf9DDZjwsLe1muD9n9GztZTWHWYVd+hvl4yeMlgPUZ/AbL7?=
 =?us-ascii?Q?G6w6RShFMLTu79R0c46Rbyl2DREUYiHXarVLJmNc6W5RkOZtn6+hoIahbo3Z?=
 =?us-ascii?Q?Z3KKHFHiW/5YRUnyN5xBrK/Jxy2P4T7BkHQRP7zapNjPHVb1rXgiR+IPfPFE?=
 =?us-ascii?Q?+5qd4OI4uqzk7i70wZGorWfx2Hi/GUmqw3sYQHC6ObUYKL9zSEHydGoQS0j8?=
 =?us-ascii?Q?qNVXe4/ibiB0/nkfZeBWg9sgRU4LQmpkkYpoNToNqkriCArXWnhtLXpCxlU6?=
 =?us-ascii?Q?sXoeBX2goge6hSRIQvLXByudGFk4GlJJTZpbix+8SZ3DhNaKSoIAkfOWI5CH?=
 =?us-ascii?Q?D+9IRuuIUExjP+E6Deu4X6cQ1RSW3rEtNa3+w6HnJStG24FtqoIQU7ter4H3?=
 =?us-ascii?Q?b6+qinWX/dZA0Z7/XtJ1cMdWCbed3p0NgOrsD+jsRy+TQDrYO/owVmOkAcgz?=
 =?us-ascii?Q?SmhqGqoooHb5NJUD+F5Iz4kdCpyFl4KLSqOEjquSGeBQRZjFzTXly8HsTPIw?=
 =?us-ascii?Q?IshiSCSmiwwlkaY3VP4VY+5p+UQxHwsvvLWdP2Dz/mTYJzW3RdmdSLl8V+2y?=
 =?us-ascii?Q?8nvClxgjsKK2x7Phk01doklGpib+eexqoD+I85OSVP59Msm/4KQszRaJjgud?=
 =?us-ascii?Q?f887UBZhrGDhyq8W8gM3OiVBk621Bt7WF18tEpowLpIHo562tWlK3sYr7d2/?=
 =?us-ascii?Q?V3PdHHkIHUCtp3Ooy3wAc5pvISUjYTQ/9Hc8jIs6w/1ekEWiFDf3DNvz80OE?=
 =?us-ascii?Q?Pysd7df+FzQz77jOF5qnBc8g7cX8E6W2WyRNNkVJnE4FXVU3eLR6UgS9cvOt?=
 =?us-ascii?Q?8K1ZwnuSBTLltQZzq8zdZcoev+37AEsW2uYuum3xfrVkF7Hdg0qpvCadn4DJ?=
 =?us-ascii?Q?noO8fwOT/a8jaOTVE6l859TYAq1YkXYaeLXpzoLOKMOtdvpOgrXtEX63+eUz?=
 =?us-ascii?Q?GExOY1UOKhEutbWLpNx0nWgDZLI5LXtQdpr97J6jCoXi4MjHR4p7211VGLTz?=
 =?us-ascii?Q?ckNJHH+dP+l6mbeZzcwknEubyEVp7GZ7+KCJIixLrNqRKjMEl+SYIl4dFkpi?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ad250d-7bcf-41f4-d073-08dab77d822f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 18:11:32.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr05pu+WvN87K6ZNDCnCf+B8ctKGEyBWhtMQHjbsU3hxv3uP/E2rWuqs+zaRwVLDiTSKQuTrd+eL3QtGwlkEIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210260103
X-Proofpoint-GUID: wBRdggOFzB4DvcbEkZFsvSGrir4HWXO4
X-Proofpoint-ORIG-GUID: wBRdggOFzB4DvcbEkZFsvSGrir4HWXO4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/26/22 10:50, Aristeu Rozanski wrote:
> On Thu, Sep 08, 2022 at 10:29:59PM +0530, Aneesh Kumar K V wrote:
> > On 9/8/22 10:23 PM, Matthew Wilcox wrote:
> > > On Thu, Sep 08, 2022 at 12:56:59PM +0530, Aneesh Kumar K.V wrote:
> > >> +++ b/fs/dax.c
> > >> @@ -1304,7 +1304,7 @@ EXPORT_SYMBOL_GPL(dax_zero_range);
> > >>  int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> > >>  		const struct iomap_ops *ops)
> > >>  {
> > >> -	unsigned int blocksize = i_blocksize(inode);
> > >> +	size_t blocksize = i_blocksize(inode);
> > >>  	unsigned int off = pos & (blocksize - 1);
> > > 
> > > If blocksize is larger than 4GB, then off also needs to be size_t.
> > > 
> > >> +++ b/fs/iomap/buffered-io.c
> > >> @@ -955,7 +955,7 @@ int
> > >>  iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> > >>  		const struct iomap_ops *ops)
> > >>  {
> > >> -	unsigned int blocksize = i_blocksize(inode);
> > >> +	size_t blocksize = i_blocksize(inode);
> > >>  	unsigned int off = pos & (blocksize - 1);
> > > 
> > > Ditto.
> > > 
> > > (maybe there are others; I didn't check closely)
> > 
> > Thanks. will check those. 
> > 
> > Any feedback on statx? Should we really fix that?
> > 
> > I am still not clear why we chose to set blocksize = pagesize for hugetlbfs.
> > Was that done to enable application find the hugetlb pagesize via stat()? 
> 
> I'd like to know that as well. It'd be easier to just limit the hugetlbfs max
> blocksize to 4GB. It's very unlikely anything else will use such large
> blocksizes and having to introduce new user interfaces for it doesn't sound
> right.

I was not around hugetlbfs when the decision was made to set 'blocksize =
pagesize'.  However, I must say that it does seem to make sense as you
can only add or remove entire hugetlb pages from a hugetlbfs file.  So,
the hugetlb page size does seem to correspond to the meaning of filesystem
blocksize.

Does any application code make use of this?  I can not make a guess.
-- 
Mike Kravetz
