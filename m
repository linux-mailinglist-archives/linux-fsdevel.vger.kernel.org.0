Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB49E1243
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 08:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbfJWGjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 02:39:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbfJWGjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:39:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9N6cO7G015061
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:39:36 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vteekn6gd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:39:36 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 23 Oct 2019 07:39:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 07:39:29 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9N6dSre52429034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 06:39:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58E274C040;
        Wed, 23 Oct 2019 06:39:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84F6C4C044;
        Wed, 23 Oct 2019 06:39:25 +0000 (GMT)
Received: from [9.199.158.207] (unknown [9.199.158.207])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 06:39:25 +0000 (GMT)
Subject: Re: [PATCH v5 04/12] ext4: introduce new callback for IOMAP_REPORT
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <f82e93ccc50014bf6c47318fd089a035d8032b28.1571647179.git.mbobrowski@mbobrowski.org>
 <20191021133715.GD25184@quack2.suse.cz>
 <20191022015535.GC5092@athena.bobrowski.net>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 23 Oct 2019 12:09:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191022015535.GC5092@athena.bobrowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102306-0012-0000-0000-0000035BE465
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102306-0013-0000-0000-0000219711A3
Message-Id: <20191023063925.84F6C4C044@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=832 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230064
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/22/19 7:25 AM, Matthew Bobrowski wrote:
> On Mon, Oct 21, 2019 at 03:37:15PM +0200, Jan Kara wrote:
>> On Mon 21-10-19 20:18:09, Matthew Bobrowski wrote:
>> One nit below.
>>> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
>>> +				  map->m_lblk, end, &es);
>>> +
>>> +	if (!es.es_len || es.es_lblk > end)
>>> +		return false;
>>> +
>>> +	if (es.es_lblk > map->m_lblk) {
>>> +		map->m_len = es.es_lblk - map->m_lblk;
>>> +		return false;
>>> +	}
>>> +
>>> +	if (es.es_lblk <= map->m_lblk)
>>
>> This condition must be always true AFAICT.
> 
> That would make sense. I will remove this condition in v6.
> 
>>> +		offset = map->m_lblk - es.es_lblk;
>>> +
>>> +	map->m_lblk = es.es_lblk + offset;

And so, this above line will also be redundant.



>>> +	map->m_len = es.es_len - offset;
>>> +
>>> +	return true;
>>> +}
> 
> --<M>--
> 

