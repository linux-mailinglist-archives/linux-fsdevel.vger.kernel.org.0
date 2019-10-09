Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88095D0FBD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfJINPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:15:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730765AbfJINPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:15:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x99DDjTb048743
        for <linux-fsdevel@vger.kernel.org>; Wed, 9 Oct 2019 09:15:04 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vhcxnyaw1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 09:15:02 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 9 Oct 2019 14:14:49 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 14:14:45 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x99DEii253018862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 13:14:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BB9211C05E;
        Wed,  9 Oct 2019 13:14:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDE6311C054;
        Wed,  9 Oct 2019 13:14:41 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 13:14:41 +0000 (GMT)
Subject: Re: [PATCH v4 3/8] ext4: introduce new callback for IOMAP_REPORT
 operations
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <cb2dcb6970da1b53bdf85583f13ba2aaf1684e96.1570100361.git.mbobrowski@mbobrowski.org>
 <20191009060022.4878542049@d06av24.portsmouth.uk.ibm.com>
 <20191009120816.GH14749@poseidon.bobrowski.net>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 9 Oct 2019 18:44:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191009120816.GH14749@poseidon.bobrowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100913-0008-0000-0000-000003207B6B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100913-0009-0000-0000-00004A3F804F
Message-Id: <20191009131441.BDE6311C054@d06av25.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090126
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/9/19 5:38 PM, Matthew Bobrowski wrote:
> On Wed, Oct 09, 2019 at 11:30:21AM +0530, Ritesh Harjani wrote:
>>> +static u16 ext4_iomap_check_delalloc(struct inode *inode,
>>> +				     struct ext4_map_blocks *map)
>>> +{
>>> +	struct extent_status es;
>>> +	ext4_lblk_t end = map->m_lblk + map->m_len - 1;
>>> +
>>> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, map->m_lblk,
>>> +				  end, &es);
>>> +
>>> +	/* Entire range is a hole */
>>> +	if (!es.es_len || es.es_lblk > end)
>>> +		return IOMAP_HOLE;
>>> +	if (es.es_lblk <= map->m_lblk) {
>>> +		ext4_lblk_t offset = 0;
>>> +
>>> +		if (es.es_lblk < map->m_lblk)
>>> +			offset = map->m_lblk - es.es_lblk;
>>> +		map->m_lblk = es.es_lblk + offset;
>> This looks redundant no? map->m_lblk never changes actually.
>> So this is not needed here.
> 
> Well, it depends if map->m_lblk == es.es_lblk + offset prior to the
> assignment? If that's always true, then sure, it'd be redundant. But
> honestly, I don't know what the downstream effect would be if this was
> removed. I'd have to look at the code, perform some tests, and figure
> it out.

<snip>
3334         if (es.es_lblk <= map->m_lblk) {
3335                 ext4_lblk_t offset = 0;
3336
3337                 if (es.es_lblk < map->m_lblk)
3338                         offset = map->m_lblk - es.es_lblk;
3339                 map->m_lblk = es.es_lblk + offset;
3340                 map->m_len = es.es_len - offset;
3341                 return IOMAP_DELALLOC;
3342         }

I saw it this way-

In condition "if (es.es_lblk <= map->m_lblk)" there are 2 cases.

Case 1: es.es_lblk is equal to map->m_lblk (equality)
    For this case, "offset" will remain 0.
    So map->lblk = es.es_lblk + 0 (but since es.es_lblk is same as
map->m_lblk in equality case, so it is redundant).


Case 2: es.es_lblk < map->m_lblk (less than)
In this case "offset = map->m_lblk - es.es_lblk"
Now replacing this val of offset in "map->m_lblk = es.es_lblk + offset"
map->m_lblk = es.es_lblk + map->m_lblk - es.es_lblk
which again is map->m_lblk = map->m_lblk - again redundant.


What did I miss?
But sure feel free to test as per your convenience.


> 
>>> +	map.m_lblk = first_block;
>>> +	map.m_len = last_block = first_block + 1;
>>> +	ret = ext4_map_blocks(NULL, inode, &map, 0);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	if (ret == 0)
>>> +		type = ext4_iomap_check_delalloc(inode, &map);
>>> +	return ext4_set_iomap(inode, iomap, type, first_block, &map);
>> We don't need to send first_block here. Since map->m_lblk
>> is same as first_block.
>> Also with Jan comment, we don't even need 'type' parameter.
>> Then we should be able to rename the function
>> ext4_set_iomap ==> ext4_map_to_iomap. This better reflects what it is
>> doing. Thoughts?
> 
> Depends on what we conclude in 1/8. :)
> 
> I'm for removing 'first_block', but still not convinced removing
> 'type' is heading down the right track if I were to forward think a
> little.

Only once you are convinced that map->m_lblk will not change even in
function ext4_iomap_check_delalloc(), then only you should
drop "first_block" argument from ext4_set_iomap.

Please check above comments once.

-ritesh

