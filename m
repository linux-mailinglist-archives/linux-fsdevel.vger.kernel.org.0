Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0156D0E60
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 14:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfJIMI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 08:08:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33033 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbfJIMI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:08:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id i76so1303801pgc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s1BWwoGjmwO49xL/8yuSea//sNNjGxnZWDCNi/EPKNE=;
        b=YmdITmbreviovSJyRzR+plEZVGUq/kjsdsI4WZN6Of6Np+kirXx36tzuphI05HKCwi
         UR9EJJFjvACIOUzCaR129hEWk+amPAYIz4BnS0rJcJ/RgitTslLYvPkNEHZAtrSYws61
         ks+OKjJo+/8/d4bR3O/iQLto4d1aYEaecFIwdTO6KVd21CupSpepBFei64nNTrdtOwwH
         +2zjRQkg2SmgBsst7POeWvY2Rxn+izWEeLqnb5KnxAHciemr0bEKTXlai55uiVJlLRpb
         TbaQsIpmmiLs8aqqmC4ROTwwNO3gxGveNZZtoQ0/AYe6WKRqTF1JRQ2Uxeph8g8HXwTS
         SIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s1BWwoGjmwO49xL/8yuSea//sNNjGxnZWDCNi/EPKNE=;
        b=I7+PRThlS6OMZgm6+KHYeaN1hoXl7n5nS6yIk2bZnC6rKda4VUxsQD3TgwIQi2j0xO
         xFU9Czw80o8/+tSnxUj6Z6FcemrxZGbOYJ/yVz1UDEjXdo/BWUPVWH/rgRnvzPmoEVt4
         hfh+w3QsdAHri/emjk5rnv4sYdQVOr2LxgF+xuk6Qly2MUxOqnLWDiTDKitMkOz0fbSv
         rR9yK/ujCZRnRvIA/N/4dq/jGntLLodTABFJ0NYNKLzVq+UNf+1C1Ppcf4DbF0/Otnl5
         LB8vhzuhc9G1eKWblVcpzVYpE2uCrs6DHBTLeHdHFCbFFlI7q3zUBmycK0QII8t3OGW9
         RNFw==
X-Gm-Message-State: APjAAAV7qv91w69wdwACTmZ7mO8APvSRjS0IlWv/eCUONmDAZWybYpD8
        zYvajm4p98orm+j2lfwiZ+FuHnmt5OqF
X-Google-Smtp-Source: APXvYqzuhuqQkShha9mtAmxxW8JgGsg3xjVouw9b/I1du0sMK1AdK/Fq4hfPqO2vPNEaMg23+tYsjA==
X-Received: by 2002:a63:c509:: with SMTP id f9mr3897327pgd.79.1570622905002;
        Wed, 09 Oct 2019 05:08:25 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id k124sm2122953pgc.6.2019.10.09.05.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 05:08:24 -0700 (PDT)
Date:   Wed, 9 Oct 2019 23:08:18 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 3/8] ext4: introduce new callback for IOMAP_REPORT
 operations
Message-ID: <20191009120816.GH14749@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <cb2dcb6970da1b53bdf85583f13ba2aaf1684e96.1570100361.git.mbobrowski@mbobrowski.org>
 <20191009060022.4878542049@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009060022.4878542049@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 11:30:21AM +0530, Ritesh Harjani wrote:
> > +static u16 ext4_iomap_check_delalloc(struct inode *inode,
> > +				     struct ext4_map_blocks *map)
> > +{
> > +	struct extent_status es;
> > +	ext4_lblk_t end = map->m_lblk + map->m_len - 1;
> > +
> > +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, map->m_lblk,
> > +				  end, &es);
> > +
> > +	/* Entire range is a hole */
> > +	if (!es.es_len || es.es_lblk > end)
> > +		return IOMAP_HOLE;
> > +	if (es.es_lblk <= map->m_lblk) {
> > +		ext4_lblk_t offset = 0;
> > +
> > +		if (es.es_lblk < map->m_lblk)
> > +			offset = map->m_lblk - es.es_lblk;
> > +		map->m_lblk = es.es_lblk + offset;
> This looks redundant no? map->m_lblk never changes actually.
> So this is not needed here.

Well, it depends if map->m_lblk == es.es_lblk + offset prior to the
assignment? If that's always true, then sure, it'd be redundant. But
honestly, I don't know what the downstream effect would be if this was
removed. I'd have to look at the code, perform some tests, and figure
it out.

> > +	map.m_lblk = first_block;
> > +	map.m_len = last_block = first_block + 1;
> > +	ret = ext4_map_blocks(NULL, inode, &map, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret == 0)
> > +		type = ext4_iomap_check_delalloc(inode, &map);
> > +	return ext4_set_iomap(inode, iomap, type, first_block, &map);
> We don't need to send first_block here. Since map->m_lblk
> is same as first_block.
> Also with Jan comment, we don't even need 'type' parameter.
> Then we should be able to rename the function
> ext4_set_iomap ==> ext4_map_to_iomap. This better reflects what it is
> doing. Thoughts?

Depends on what we conclude in 1/8. :)

I'm for removing 'first_block', but still not convinced removing
'type' is heading down the right track if I were to forward think a
little.

--<M>--

