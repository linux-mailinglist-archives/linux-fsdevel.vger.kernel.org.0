Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE664ACF77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 04:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbiBHDDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 22:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346027AbiBHDDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:03:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA4CC0401D9;
        Mon,  7 Feb 2022 19:03:37 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2181cRFj022974;
        Tue, 8 Feb 2022 03:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fXZpxxrg2f39L11K80Gjnr3U/C8pg5hF3KeHL8WFg+E=;
 b=Sl00Xo6M9iRll7+A7vpVAQn2KxxYP0Kz5z2lXx5+JC7GNq/QCtBRG/lN8YeJIEQWDG7O
 NhJXuA4iSdPFYGbb/KMfmt91ssENs9fhkQWLyNML8q5Gd1Gs8TP87lzIATUxtw2jmFx1
 5Xjky22XQmCmptL13qz1ZS1bSMNJVcJn6Yi33ZAaUrBduh8g5IpgPFU6BBPoCoyy63u1
 +ajO5Gq7nqBQEUPLf9FqphXFhfFVmMOD1LBTq9aJXYs1fj+VEalY0gjik+xi9RuVWGSQ
 L9mjDOT9wbE1t7A87oj91C+YDL1vUpRpND49OV8HJO1NcDNvFrQiVRfn7u6MbXWAMkek KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22kqdsk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 03:03:32 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2182ubcY011505;
        Tue, 8 Feb 2022 03:03:31 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22kqdsfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 03:03:31 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2182d3To013365;
        Tue, 8 Feb 2022 03:03:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3e1gva0w6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 03:03:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218339PL40960504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 03:03:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F04E411C050;
        Tue,  8 Feb 2022 03:03:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B28C11C04A;
        Tue,  8 Feb 2022 03:03:08 +0000 (GMT)
Received: from localhost (unknown [9.43.111.247])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 03:03:08 +0000 (GMT)
Date:   Tue, 8 Feb 2022 08:33:07 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCHv1 7/9] ext4: Add ext4_sb_block_valid() refactored out of
 ext4_inode_block_valid()
Message-ID: <20220208030307.watnlz7rq7z2yb2y@riteshh-domain>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
 <1c5fae30be49b5116e4e5604e6224b33b778feaf.1644062450.git.riteshh@linux.ibm.com>
 <20220207164241.voulrwcz4ib2ujoz@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207164241.voulrwcz4ib2ujoz@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KNa0q7wtTMRNxlfTX-57iwSvbwQf8pSW
X-Proofpoint-ORIG-GUID: K-GwPHUp1OkfmFCJfjNjR5DMtaoVjkT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=771 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/02/07 05:42PM, Jan Kara wrote:
> On Sat 05-02-22 19:39:56, Ritesh Harjani wrote:
> > This API will be needed at places where we don't have an inode
> > for e.g. while freeing blocks in ext4_group_add_blocks()
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> ...
>
> > @@ -329,7 +324,8 @@ int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
> >  		else if (start_blk >= (entry->start_blk + entry->count))
> >  			n = n->rb_right;
> >  		else {
> > -			ret = (entry->ino == inode->i_ino);
> > +			if (inode)
> > +				ret = (entry->ino == inode->i_ino);
> >  			break;
>
> In case inode is not passed, we must not overlap any entry in the rbtree.
> So we should return 0, not 1.
>
Damm! Thanks for catching that. Don't know how did I miss that.
Will make this below change then.
	else {
		ret = 0;
		if (inode)
			ret = (entry->ino == inode->i_ino)
		break;
	}

-riteshh

> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
