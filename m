Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53166379D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 04:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjAJDEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 22:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbjAJDDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:03:44 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CD4262F;
        Mon,  9 Jan 2023 19:03:37 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y5so7745343pfe.2;
        Mon, 09 Jan 2023 19:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ie+rQH3mw2D5QoODuQ+CCdhtheNQpe0s3cmjyE1gSeQ=;
        b=hMJOr7gxNfRVXvptQWjnS8gggJmoU39dG01sMuSVgD+06ybLXZxq90y4dy3c96NbGF
         4ZT28Zq5UNherNLr00lPvH90N3EtrGwKCZ5w+s+Nk7G+2SJ6ZKT+sq5tu3EE3ULu3Kzw
         Tm1vipafgC4nL3i2C3ESwkGPiXyNWjk+DYNU5oYqzgFvUp2yw2WsLbuNqo2V0DWUVU/R
         4Q3HdEc6KdveDXPof/4iD/sv+HhtzWh5llcfA936NmkiAVO0yiQADoU9L8RAKYAkCMXx
         OowkMMJOMwmhX7BhL3tGmOP0dsjKWzhGNwVwtSMWuQP00OtD1lRZF8xUGLuC3jp0h/rG
         Im3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie+rQH3mw2D5QoODuQ+CCdhtheNQpe0s3cmjyE1gSeQ=;
        b=PQjBk+pE2GhVcLC+dyjSVYlIZk4vDy5cOHOtMyHA0ZKjVG2KQRuIBdQYXBwykwj0S+
         7nDwhKSmGOPC6PdHDl3svSrHawBUso5FcxBg0blmKa8oR6bzTI1/ArBy/4FDP15OzT4E
         m5LeOpWd385b09gUhGkDZQXMpVF5iEQ7oeSKyDud43gkSGLpjD0wOQaYkMUeVJaUhb9y
         ytvEggYCKdjgplGOdWt2FaAIZKQ2vs8b9tF2GZzh30uaZwLqWGTOUts1Q9uggVrR3t8t
         QlAzhR9YmHbVSWF5txvMe6XahkSzme5cxFFO9fmNMSQptZYxcor2qgLzoqXRNf/7NfoQ
         c/xw==
X-Gm-Message-State: AFqh2krcSwGJoR7GAsioD3uQdMJAh53uMhxIxjPCJ5ae50erkKKp0hXm
        QuHJJ3z5vhzHIvI8hhypfUU=
X-Google-Smtp-Source: AMrXdXvJDNVJzGLOc0X2GvVwdFjI8RfAavc5gUlJ2WeGpNuCy2JjwDpIY0RBpj1yDjgL50FOUueSBQ==
X-Received: by 2002:a05:6a00:2281:b0:581:a8dc:8f95 with SMTP id f1-20020a056a00228100b00581a8dc8f95mr53203339pfe.12.1673319816855;
        Mon, 09 Jan 2023 19:03:36 -0800 (PST)
Received: from [30.221.133.30] ([47.246.101.62])
        by smtp.gmail.com with ESMTPSA id y12-20020a62640c000000b005819313269csm6749208pfb.124.2023.01.09.19.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 19:03:36 -0800 (PST)
Message-ID: <8c4cbb93-cba5-82b4-74c5-0ff1dcc214a1@gmail.com>
Date:   Tue, 10 Jan 2023 11:03:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [Ocfs2-devel] [PATCH 6/7] ocfs2: don't use write_one_page in
 ocfs2_duplicate_clusters_by_page
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        jfs-discussion@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-btrfs@vger.kernel.org
References: <20230108165645.381077-1-hch@lst.de>
 <20230108165645.381077-7-hch@lst.de>
From:   Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <20230108165645.381077-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/9/23 12:56 AM, Christoph Hellwig via Ocfs2-devel wrote:
> Use filemap_write_and_wait_range to write back the range of the dirty
> page instead of write_one_page in preparation of removing write_one_page
> and eventually ->writepage.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/refcounttree.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index 623db358b1efa8..4a73405962ec4f 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -2952,10 +2952,11 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
>  		 */
>  		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize) {
>  			if (PageDirty(page)) {
> -				/*
> -				 * write_on_page will unlock the page on return
> -				 */
> -				ret = write_one_page(page);
> +				unlock_page(page);
> +				put_page(page);
> +
> +				ret = filemap_write_and_wait_range(mapping,
> +						offset, map_end - 1);
>  				goto retry;
>  			}
>  		}
