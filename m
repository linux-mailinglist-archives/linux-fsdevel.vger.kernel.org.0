Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD18250F44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfFXOyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:54:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42380 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFXOyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:54:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OEmx7U147775;
        Mon, 24 Jun 2019 14:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lFEQjisrEmEvK2jGaVdi3n8j6DM4Ef5vV20LlilvkbU=;
 b=YZfqP8DjG8Gc3lIwkSe7vsqkZVcXBinhY/BKunCePvj/gXgxrOAEVAd4RELmzSJXO62M
 a7ryJchGwvuM4UfUTnHGrErX4Z9VjuGWoNOr/7yGwwP2GK39HlWft02re++yenASJPPl
 9vpIid+t+mtg0PNeDVxS1gCt1IW7vp2lymQ4tmf3JZTLqss6x7575pqLoIyLGmNsioWs
 xieg5y7+3va8RRInd1tzPSKo9NU8LAuIq8KE1zEEU7iXhxVrh/6I1iihO6VR2J8A3vZT
 JIIJXF6QBugqDqs0uvMpdAdJ66UnLUUwjj26JwZhPp14qxjHpvHFXbor2wexcXmH+CLW 9Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9pevkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 14:53:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OErMsL093958;
        Mon, 24 Jun 2019 14:53:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7bpacw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 14:53:36 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OErYTo021827;
        Mon, 24 Jun 2019 14:53:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 07:53:34 -0700
Date:   Mon, 24 Jun 2019 07:53:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] list.h: add a list_pop helper
Message-ID: <20190624145325.GF5387@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:42AM +0200, Christoph Hellwig wrote:
> We have a very common pattern where we want to delete the first entry
> from a list and return it as the properly typed container structure.
> 
> Add a list_pop helper to implement this behavior.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/list.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index e951228db4b2..e07a5f54cc9d 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -500,6 +500,28 @@ static inline void list_splice_tail_init(struct list_head *list,
>  	pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
>  })
>  
> +/**
> + * list_pop - delete the first entry from a list and return it
> + * @list:	the list to take the element from.
> + * @type:	the type of the struct this is embedded in.
> + * @member:	the name of the list_head within the struct.
> + *
> + * Note that if the list is empty, it returns NULL.
> + */
> +#define list_pop(list, type, member) 				\

Unnecessary space after the ')' here, though I can fix that up if I
merge this version of the series...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D


> +({								\
> +	struct list_head *head__ = (list);			\
> +	struct list_head *pos__ = READ_ONCE(head__->next);	\
> +	type *entry__ = NULL;					\
> +								\
> +	if (pos__ != head__) {					\
> +		entry__ = list_entry(pos__, type, member);	\
> +		list_del(pos__);				\
> +	}							\
> +								\
> +	entry__;						\
> +})
> +
>  /**
>   * list_next_entry - get the next element in list
>   * @pos:	the type * to cursor
> -- 
> 2.20.1
> 
