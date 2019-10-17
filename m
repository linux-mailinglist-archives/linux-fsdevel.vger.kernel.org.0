Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A56DA291
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 02:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438188AbfJQAHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 20:07:10 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40845 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfJQAHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 20:07:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id y144so233272qkb.7;
        Wed, 16 Oct 2019 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZguwGHkKiTqA9eXWGz+ucfugQsHP1T25nPopQKfBpM4=;
        b=Q39xbnBARE+lypH4GuZW0nbu7H94Q2f5dW1u/kr8F4dlTRfLvX9NYZCQDr0pVAl9Du
         o6ZavB/pjbqxBj5Y5A7dpHDgJSA2mBq5GfyocL9rXQ9FauMgBkcJ/VhyDrj+t9BhEnRO
         CUCRidHBaOLaBKPj9QKbUdTWGxKeu4yme10hnKT+CZvOY8Q8oa5POmmF2n2tivdMNEjj
         kfQ0dbT4E7fjkHkmBD1JlDN4yXgRflrrTiII+d2XH2eRmRD8scqesH2+VkdFwJv1EH7R
         3l0bfo/+kEjEh/MBtzofKeg+jrJyyWGGBUxfLtNHIsSWYqbWAMQc7J6KZNYv/B7kOsgy
         jiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZguwGHkKiTqA9eXWGz+ucfugQsHP1T25nPopQKfBpM4=;
        b=O7JeOuwE7pUKeyztO+w7NesbWrdtODWqzAYqXaP9RBZtCqHTxcrcXIAEn97lIvHCXK
         V4FNbz7aRf7ErpJ9wDuI9zQOEc5PCkkzepgRb9XWWyAfRSjcEqAsSf0KBndofwq8/jO5
         RIu55OfKTkdM7k00JzCiLj/xxnA5KZDrLQ1288D1iBudzrTiedmffVdzdiG5f40GTXNk
         cRWe4udznpIWK3OgQb3sro1hEgxCU4OEAkVVq6cpz9aK1AzKzXkiRxNWf1R33T18fNfe
         9DD4Ax+jyXyt/aqrNS6p5cy65p7j832HWpy9AVoPqi3c1eX30/3cBPhajuL2q0iCX1a1
         SeSw==
X-Gm-Message-State: APjAAAVbxqjCv4JFjcKoWk6JuK50Oa5+k6d7/TeI+uVFjZdet/ps1oen
        +Va8NxzBrDIFHn6pqpSQ/E03Qs45
X-Google-Smtp-Source: APXvYqy1lBQZcYGLdE7jsm9s8kpvhqaYFZjHmNNt0eaWgw6mv9u9bAx8A/5rkb2HmyEYYfFQX43qSw==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr697731qkm.350.1571270829408;
        Wed, 16 Oct 2019 17:07:09 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id r7sm280728qkf.124.2019.10.16.17.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 17:07:08 -0700 (PDT)
Date:   Wed, 16 Oct 2019 21:07:03 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hfsplus: add a check for hfs_bnode_find
Message-ID: <20191017000703.GA4271@eaf>
References: <20191016120621.304-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016120621.304-1-hslester96@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, Oct 16, 2019 at 08:06:20PM +0800, Chuhong Yuan wrote:
> hfs_brec_update_parent misses a check for hfs_bnode_find and may miss
> the failure.
> Add a check for it like what is done in again.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  fs/hfsplus/brec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index 1918544a7871..22bada8288c4 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -434,6 +434,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
>  			new_node->parent = tree->root;
>  		}
>  		fd->bnode = hfs_bnode_find(tree, new_node->parent);
> +		if (IS_ERR(fd->bnode))
> +			return PTR_ERR(fd->bnode);

You shouldn't just return here, you still hold a reference to new_node.
The call to hfs_bnode_find() after the again label seems to be making a
similar mistake.

I don't think either one can actually fail though, because the parent
nodes have all been read and hashed before, haven't they?

>  		/* create index key and entry */
>  		hfs_bnode_read_key(new_node, fd->search_key, 14);
>  		cnid = cpu_to_be32(new_node->this);
> -- 
> 2.20.1
> 
