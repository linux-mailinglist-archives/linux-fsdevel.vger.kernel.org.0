Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B82F166E56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 05:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgBUEQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 23:16:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729766AbgBUEQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:16:54 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L4BCLK188307
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 23:16:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ucnse9p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 23:16:52 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 21 Feb 2020 04:16:50 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 04:16:46 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L4GjSd60424362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 04:16:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DECAC52057;
        Fri, 21 Feb 2020 04:16:45 +0000 (GMT)
Received: from [9.199.159.36] (unknown [9.199.159.36])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 53A9852052;
        Fri, 21 Feb 2020 04:16:44 +0000 (GMT)
Subject: Re: [RFCv2 0/4] ext4: bmap & fiemap conversion to use iomap
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        tytso@mit.edu
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cmaiolino@redhat.com
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <20200130160018.GC3445353@magnolia>
 <20200205124750.AE9DDA404D@d06av23.portsmouth.uk.ibm.com>
 <20200205155733.GH6874@magnolia>
 <20200206052619.D4BBCA405F@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20200206102254.GK14001@quack2.suse.cz>
 <20200220170304.80C3E52051@d06av21.portsmouth.uk.ibm.com>
 <20200220170953.GA11221@infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 21 Feb 2020 09:46:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200220170953.GA11221@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022104-0016-0000-0000-000002E8D171
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022104-0017-0000-0000-0000334BF058
Message-Id: <20200221041644.53A9852052@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=736
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210027
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/20/20 10:39 PM, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 10:33:03PM +0530, Ritesh Harjani wrote:
>> So I was making some changes along the above lines and I think we can take
>> below approach for filesystem which could determine the
>> _EXTENT_LAST relatively easily and for cases if it cannot
>> as Jan also mentioned we could keep the current behavior as is and let
>> iomap core decide the last disk extent.
> 
> Well, given that _EXTENT_LAST never worked properly on any file system
> since it was added this actually changes behavior and could break
> existing users.  I'd rather update the documentation to match reality
> rather than writing a lot of code for a feature no one obviously cared
> about for years.

Well I agree to this. Since either ways the _EXTENT_LAST has never 
worked properly or in the same manner across different filesystems.
In ext4 itself it works differently for extent v/s non-extent based FS.
So updating the documentation would be a right way to go from here.

Ted/Jan - do you agree here:-
Shall we move ahead with this patch series in converting ext4_fiemap to
use iomap APIs, without worrying about how _EXTENT_LAST is being set via
iomap core code?



-ritesh

