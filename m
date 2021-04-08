Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E981358132
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 12:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhDHK5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 06:57:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229640AbhDHK5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:57:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138AYKLh095072;
        Thu, 8 Apr 2021 06:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=1JvBFbXy1nAaQYFqmVrjybnlj0o+45Pq/1RhO7aPzqs=;
 b=A1+pJuBXDh9fN1jBTfcp2NxcYSspyH6NKvSLXc3q1RbklDSml++o1PBQN41z72gbf6nM
 TuCxy4NUzuPS9EaOVkiJUnmfKrvuKONdM+SCx5mFRI1QigulEN7P7XY30h/97Alr3IWi
 ZeL23TRSsq328SjLc5f/tgYvLatM4ZvJAHNi6YRUybaEhkqsRrQsgl8j5LuHoNUTEH1W
 6DnBmAv0CMu0lMIWzFOEEYHRVFTpkubWoAgRxnHbkIrDyXHlxu0l5BvskZuYQfuSSLZ6
 K1oPyOb1gVjJTzTfQzgAOVkFt3Hg/ZLYFbC3wxK3GVC5bui9UGhXEXLqtXCO8OcVGxQS Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37rw088fvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 06:57:11 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 138AmXrv161851;
        Thu, 8 Apr 2021 06:57:11 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37rw088fuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 06:57:11 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138AmKEH023805;
        Thu, 8 Apr 2021 10:57:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 37rvc5gt87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 10:57:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138Auki536307416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 10:56:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3530EAE051;
        Thu,  8 Apr 2021 10:57:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6505AE045;
        Thu,  8 Apr 2021 10:57:06 +0000 (GMT)
Received: from localhost (unknown [9.85.70.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Apr 2021 10:57:06 +0000 (GMT)
Date:   Thu, 8 Apr 2021 16:27:05 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        Brendan Gregg <bgregg@netflix.com>
Subject: Re: [PATCH 0/3] readahead improvements
Message-ID: <20210408105705.exod2cvtvnr4467o@riteshh-domain>
References: <20210407201857.3582797-1-willy@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407201857.3582797-1-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6gJR7__kIDqB--F8SI89lnUVnUbFklX2
X-Proofpoint-GUID: ykjPFvtqJT8-Fe_s7V45sfU35xtzCI8c
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_02:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080071
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/04/07 09:18PM, Matthew Wilcox (Oracle) wrote:
> As requested, fix up readahead_expand() so as to not confuse the ondemand
> algorithm.  Also make the documentation slightly better.  Dave, could you
> put in some debug and check this actually works?  I don't generally test
> with any filesystems that use readahead_expand(), but printing (index,
> nr_to_read, lookahead_size) in page_cache_ra_unbounded() would let a human
> (such as your good self) determine whether it's working approximately
> as designed.

Hello,

Sorry about the silly question here, since I don't have much details of how
readahead algorithm code path.

1. Do we know of a way to measure efficiency of readahead in Linux?
2. And if there is any way to validate readahead is working correctly and as
   intended in Linux?
Like is there anything designed already to measure above two things?
If not, are there any stats which can be collected and later should be parsed to
say how efficient readahead is working in different use cases and also can
verify if it's working correctly?

I guess, we can already do point 1 from below. What about point 2 & 3?
1. Turn on/off the readahead and measure file reads timings for different
   patterns. - I guess this is already doable.

2. Collecting runtime histogram showing how readahead window is
   increasing/decreasing based on changing read patterns. And collecting how
   much IOs it takes to increase/decrease the readahead size.
   Are there any tracepoints needed to be enabled for this?

3. I guess it won't be possible w/o a way to also measure page cache
   efficiency. Like in case of a memory pressure, if the page which was read
   using readahead is thrown out only to re-read it again.
   So a way to measure page cache efficiency also will be required.

Any idea from others on this?

I do see below page[1] by Brendan showing some ways to measure page cache
efficiency using cachestat. But there are also some problems mentioned in the
conclusion section, which I am not sure of what is the latest state of that.
Also it doesn't discusses much on the readahead efficiency measurement.

[1]: http://www.brendangregg.com/blog/2014-12-31/linux-page-cache-hit-ratio.html

