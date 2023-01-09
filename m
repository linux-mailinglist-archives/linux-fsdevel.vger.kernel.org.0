Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33614661D17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 04:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjAIDz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 22:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjAIDzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:55:20 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C79411C29
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 19:54:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d15so8191767pls.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jan 2023 19:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpgfqkNhPqEV+WEtXe6exPW4ehifsekBo6yCYNhed1Q=;
        b=2+Y/8pxMywf4CuY6rlA26Z8wlez6yJKwtYUVrUxQUWc4Jfip0sOQU4a6bJ379AYtE5
         +Kb5CYmTtVwHP/5MDDCmurkG9wu8slKevWOvWTfcvRd7Ixny78Tuo+6N7diZ8GuLy/e9
         onreXGi5DCuTn/6kdNwIHNEFbeQXZv1P+zT3hcEZvpYkMOxtqAxe1F2FumunVb2Z67Rr
         dDiR17uCH+iunJiXUfKY6JU59DVx8qZZV1s7jU1znvDXo0u1sFsleVJsV3CK3u5uLf/g
         sIJx+pqtlO3sFqNcA7UGUzhv29M/sLZIz6pFaC5XIsBU4bBfVDI1McQyVo7Bp6jiv+Gd
         ACEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpgfqkNhPqEV+WEtXe6exPW4ehifsekBo6yCYNhed1Q=;
        b=oPeVXfzIG4+W+D3ig5nYSes9ecBIVosHJWNTxXp2fL+E8Lcede/+wbfaxEgTU4oZiP
         1gIdXAKw+6xRbd84bpe7h1RPQ4RcirR12H5cjygkkoYM4MkmCNX3v/S1nFoCp+8LFgmG
         qUBR8vV/uHL99352qoDPWM/mbXaf0QyECCWDtkLrZAJh7ZTYWFe8UzPGz0foG9PKdpBh
         629Xv3uzziJI8SbS1bO4MC6KvcFOFRATX+KWnNEVtAR8OJc9NGMazUSS6BbJC6v2nQft
         YVr/vAvzLPH623UGq9gBPVxfqeFYkoKemfxQmlIcwqbJcT/sRNU0FSjew7NmpM/ycTgO
         REog==
X-Gm-Message-State: AFqh2koMElEAsPaTLqEpm80OuVCHtjfYhj3/5b+yPKuYCFkXjvnXOchm
        CJEBS/OjiSjOGT5y7Pff41y2Yg==
X-Google-Smtp-Source: AMrXdXtbWiVAhvv6GGx94sLoPaPE9wd7oOx9Z+AqkblebDe83VF4n/+AvJWc6ANJaIpfj5Qq/2w6cQ==
X-Received: by 2002:a17:902:cf91:b0:193:2d46:abe0 with SMTP id l17-20020a170902cf9100b001932d46abe0mr733811ply.6.1673236453985;
        Sun, 08 Jan 2023 19:54:13 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b00192a3e13b39sm3546210pli.264.2023.01.08.19.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 19:54:13 -0800 (PST)
Message-ID: <d86e6340-534c-c34c-ab1d-6ebacb213bb9@kernel.dk>
Date:   Sun, 8 Jan 2023 20:54:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages rather
 than ref'ing if appropriate
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
 <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/6/23 5:34 PM, David Howells wrote:
> Convert the block layer's bio code to use iov_iter_extract_pages() instead
> of iov_iter_get_pages().  This will pin pages or leave them unaltered
> rather than getting a ref on them as appropriate to the source iterator.
> 
> A field, bi_cleanup_mode, is added to the bio struct that gets set by
> iov_iter_extract_pages() with FOLL_* flags indicating what cleanup is
> necessary.  FOLL_GET -> put_page(), FOLL_PIN -> unpin_user_page().  Other
> flags could also be used in future.
> 
> Newly allocated bio structs have bi_cleanup_mode set to FOLL_GET to
> indicate that attached pages are ref'd by default.  Cloning sets it to 0.
> __bio_iov_iter_get_pages() overrides it to what iov_iter_extract_pages()
> indicates.

What's the motivation for this change? It's growing struct bio, which we
can have a lot of in the system. I read the cover letter too and I can
tell what the change does, but there's no justification really for the
change.

So unless there's a good reason to do this, then that's a NAK in terms
of just the addition to struct bio alone.

-- 
Jens Axboe


