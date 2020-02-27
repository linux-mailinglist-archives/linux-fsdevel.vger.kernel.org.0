Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 333A6171012
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 06:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgB0FSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 00:18:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgB0FSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:18:04 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R5F7MW018842
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 00:18:03 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydcnu982j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 00:18:03 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 27 Feb 2020 05:18:00 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Feb 2020 05:17:56 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01R5HuoZ52494494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 05:17:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F225342042;
        Thu, 27 Feb 2020 05:17:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD17B42052;
        Thu, 27 Feb 2020 05:17:53 +0000 (GMT)
Received: from [9.199.158.169] (unknown [9.199.158.169])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 05:17:53 +0000 (GMT)
Subject: Re: [PATCHv3 6/6] Documentation: Correct the description of
 FIEMAP_EXTENT_LAST
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <279638c6939b1f6ef3ab32912cb51da1a967cf8e.1582702694.git.riteshh@linux.ibm.com>
 <20200226130503.GY24185@bombadil.infradead.org>
 <20200226161742.GB8036@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 27 Feb 2020 10:47:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200226161742.GB8036@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022705-0028-0000-0000-000003DE5F85
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022705-0029-0000-0000-000024A37D85
Message-Id: <20200227051753.CD17B42052@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002270039
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/26/20 9:47 PM, Darrick J. Wong wrote:
> On Wed, Feb 26, 2020 at 05:05:03AM -0800, Matthew Wilcox wrote:
>> On Wed, Feb 26, 2020 at 03:27:08PM +0530, Ritesh Harjani wrote:
>>> Currently FIEMAP_EXTENT_LAST is not working consistently across
>>> different filesystem's fiemap implementations and thus this feature
>>> may be broken. So fix the documentation about this flag to meet the
>>> right expectations.
>>
>> Are you saying filesystems have both false positives and false negatives?
>> I can understand how a filesystem might fail to set FIEMAP_EXTENT_LAST,
>> but not how a filesystem might set it when there's actually another
>> extent beyond this one.
>>
>>>   * FIEMAP_EXTENT_LAST
>>> -This is the last extent in the file. A mapping attempt past this
>>> -extent will return nothing.
>>> +This is generally the last extent in the file. A mapping attempt past this
>>> +extent may return nothing. But the user must still confirm by trying to map
>>> +past this extent, since different filesystems implement this differently.
> 
> "This flag means nothing and can be set arbitrarily by the fs for the lulz."
> 

:) Got it. Will add more information to it.


> Yuck.  I was really hoping for "This is set on the last extent record in
> the dataset generated by the query parameters", particularly becaue
> that's how e2fsprogs utilties interpret that flag.

-extent may return nothing. But the user must still confirm by trying to map
-past this extent, since different filesystems implement this differently.
+extent may return nothing. In some implementations this flag is also set on
+the last dataset queried by the user (via fiemap->fm_length).


Let me know if above looks good.

-ritesh

