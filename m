Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C08163CAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 06:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgBSFbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 00:31:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44754 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgBSFbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 00:31:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J5VHMn112939;
        Wed, 19 Feb 2020 05:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=KgqFBVhXm0DLAhBnOcBKslL8VU948dAFh2h2NcXWn4w=;
 b=ITCEApkm+o2RKOO33pUDQ6SIA2cbmm2Z2FPabsmu5NzaoFoqf1qD5JrOszi/4GAmXYt1
 NHQeNPPmueToxUMlEf0wrGSUMk1H/MvgUGZGk/Grxb0CxhmoL0VCj6bs3TbxFSNpgIYI
 1b7c2cCg9XzmYZL6jAeuLAQAAs/jnv+WEOIxy/EVzblSpuQiUG8DI4eAfFOJuHRkGcrB
 k6u631N9YTr6tt6fn+BtMHXg9mZVs1KAXTCNrkanolBrSAdPUAoxuhF/bhi6rkD+AnRD
 XIFKrnAzr7plW1B6upKjj3mgixk7NZd0V1ZpqYC0Qgfw+6//COMUjwewWKKRAEvuLGrB Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y8udk8mq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 05:31:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J5RpSv156791;
        Wed, 19 Feb 2020 05:29:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y8ud3dvqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 05:29:31 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01J5TUHL005098;
        Wed, 19 Feb 2020 05:29:30 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 21:29:30 -0800
Date:   Wed, 19 Feb 2020 08:29:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Alexey Dobriyan <adobriyan@gmail.com>
Cc:     kbuild-all@lists.01.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: faster open/read/close with "permanent" files
Message-ID: <20200219052921.GF19641@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216152649.GA2693@avx2>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190037
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexey,


url:    https://github.com/0day-ci/linux/commits/Alexey-Dobriyan/proc-faster-open-read-close-with-permanent-files/20200218-231203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/proc/generic.c:752 remove_proc_subtree() warn: inconsistent returns 'proc_subdir_lock'.

# https://github.com/0day-ci/linux/commit/3cd4ad42ca7c52d1513e7ba9f08a06197a7380c8
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 3cd4ad42ca7c52d1513e7ba9f08a06197a7380c8
vim +/proc_subdir_lock +752 fs/proc/generic.c

8ce584c7416d8a Al Viro         2013-03-30  699  
8ce584c7416d8a Al Viro         2013-03-30  700  int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
8ce584c7416d8a Al Viro         2013-03-30  701  {
8ce584c7416d8a Al Viro         2013-03-30  702  	struct proc_dir_entry *root = NULL, *de, *next;
8ce584c7416d8a Al Viro         2013-03-30  703  	const char *fn = name;
8ce584c7416d8a Al Viro         2013-03-30  704  	unsigned int len;
8ce584c7416d8a Al Viro         2013-03-30  705  
ecf1a3dfff22bd Waiman Long     2015-09-09  706  	write_lock(&proc_subdir_lock);
8ce584c7416d8a Al Viro         2013-03-30  707  	if (__xlate_proc_name(name, &parent, &fn) != 0) {
ecf1a3dfff22bd Waiman Long     2015-09-09  708  		write_unlock(&proc_subdir_lock);
8ce584c7416d8a Al Viro         2013-03-30  709  		return -ENOENT;
8ce584c7416d8a Al Viro         2013-03-30  710  	}
8ce584c7416d8a Al Viro         2013-03-30  711  	len = strlen(fn);
8ce584c7416d8a Al Viro         2013-03-30  712  
710585d4922fd3 Nicolas Dichtel 2014-12-10  713  	root = pde_subdir_find(parent, fn, len);
8ce584c7416d8a Al Viro         2013-03-30  714  	if (!root) {
ecf1a3dfff22bd Waiman Long     2015-09-09  715  		write_unlock(&proc_subdir_lock);
8ce584c7416d8a Al Viro         2013-03-30  716  		return -ENOENT;
8ce584c7416d8a Al Viro         2013-03-30  717  	}
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  718  	if (unlikely(pde_is_permanent(root))) {
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  719  		WARN(1, "removing permanent /proc entry '%s/%s'",
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  720  			root->parent->name, root->name);

unlock?

3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  721  		return -EINVAL;
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  722  	}
4f1134370a29a5 Alexey Dobriyan 2018-04-10  723  	rb_erase(&root->subdir_node, &parent->subdir);
710585d4922fd3 Nicolas Dichtel 2014-12-10  724  
8ce584c7416d8a Al Viro         2013-03-30  725  	de = root;
8ce584c7416d8a Al Viro         2013-03-30  726  	while (1) {
710585d4922fd3 Nicolas Dichtel 2014-12-10  727  		next = pde_subdir_first(de);
8ce584c7416d8a Al Viro         2013-03-30  728  		if (next) {
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  729  			if (unlikely(pde_is_permanent(root))) {
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  730  				WARN(1, "removing permanent /proc entry '%s/%s'",
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  731  					next->parent->name, next->name);
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  732  				return -EINVAL;
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  733  			}
4f1134370a29a5 Alexey Dobriyan 2018-04-10  734  			rb_erase(&next->subdir_node, &de->subdir);
8ce584c7416d8a Al Viro         2013-03-30  735  			de = next;
8ce584c7416d8a Al Viro         2013-03-30  736  			continue;
8ce584c7416d8a Al Viro         2013-03-30  737  		}
8ce584c7416d8a Al Viro         2013-03-30  738  		next = de->parent;
8ce584c7416d8a Al Viro         2013-03-30  739  		if (S_ISDIR(de->mode))
8ce584c7416d8a Al Viro         2013-03-30  740  			next->nlink--;
e06689bf57017a Alexey Dobriyan 2019-12-04  741  		write_unlock(&proc_subdir_lock);
e06689bf57017a Alexey Dobriyan 2019-12-04  742  
e06689bf57017a Alexey Dobriyan 2019-12-04  743  		proc_entry_rundown(de);
8ce584c7416d8a Al Viro         2013-03-30  744  		if (de == root)
8ce584c7416d8a Al Viro         2013-03-30  745  			break;
8ce584c7416d8a Al Viro         2013-03-30  746  		pde_put(de);
8ce584c7416d8a Al Viro         2013-03-30  747  
ecf1a3dfff22bd Waiman Long     2015-09-09  748  		write_lock(&proc_subdir_lock);
8ce584c7416d8a Al Viro         2013-03-30  749  		de = next;
8ce584c7416d8a Al Viro         2013-03-30  750  	}
8ce584c7416d8a Al Viro         2013-03-30  751  	pde_put(root);
8ce584c7416d8a Al Viro         2013-03-30 @752  	return 0;
8ce584c7416d8a Al Viro         2013-03-30  753  }
8ce584c7416d8a Al Viro         2013-03-30  754  EXPORT_SYMBOL(remove_proc_subtree);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
