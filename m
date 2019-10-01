Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CBFC3191
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 12:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfJAKgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 06:36:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44596 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJAKf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:35:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id r16so11382963edq.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2019 03:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZNGuyH5VuGfp79kfCmqyKc3sZNZ698HUAysJogIW8J8=;
        b=GvWY6ZvGINP8k5fiHp2HCSyp++QYkRNHtKNKitVSQrpOL5yKvYytHwMSmIDySSNp9p
         BppOYXqm0K6ivvDJ+RIo1C22GSXi1/NMeRedaDWOnvnfYBVuatjVUdteMt7V4+B7CE8G
         HM2Av4gCcd6NwITVA0MBfQOqQ4wcuRNhns/lauZgGyCd6LUHpKQ+zSaVLZVw7DwyFX5A
         B0BL7HrR89eTEQFUrTb02YNbn6bZHmEh+4HjahRkUrb66lSX8Kpn4B9Wz6FTt05nzwdB
         9jZ2+hXPD0rOEKByN+gpCx17AsxMS6SyjD7oUcm63jGlMnu8tpllxDDI/sJ4v7RWkxnO
         MJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZNGuyH5VuGfp79kfCmqyKc3sZNZ698HUAysJogIW8J8=;
        b=f/o8d6sLcBveCx91eo5hOPyJYKGupTjt3ojgRxkCGTjlddQRJrGG2BsheRSkuvjbe7
         yM7pw7IWXqK7Oez0PXD2wBorXmTj5iJMh3UlmPgnKamh0dj584HEVhx2biPo2R9E6D82
         CHkarvE1SGbxtnfs58vlY4ACLMTWsgLFTq9x08ILx2SEBAA4Jt51oWTxZJie9kQl4jzv
         Rd1om5YdpZ/nW9NinlEkc8h8ZmbLDpKGHJVJuIZlUe2BOTjgjkx0T92Uvfb0m/1GMCOj
         wvmdhWxbROmiuzckrCvGY2LGveTx6wN9FXmQg8Tud9Mx+pvxzTkWcQnhNvNwv86a+QHZ
         lwzw==
X-Gm-Message-State: APjAAAWhidYj/XKC7w0LrwjsFYefkNZ0nkeopYMg2p3vN5KdpBAEC5hb
        10Qi4rSgy7UV/sHk59Kmk72tEw==
X-Google-Smtp-Source: APXvYqz87K8iJr9+PvdkjESjYxltd3GHd5aNw6kR4j971RAwDiqE2AOgqRqlUqNxEnnFUERsZY3ZGg==
X-Received: by 2002:a17:906:c82d:: with SMTP id dd13mr12497351ejb.169.1569926157970;
        Tue, 01 Oct 2019 03:35:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i30sm3057790ede.32.2019.10.01.03.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 03:35:57 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ECBB2102FB8; Tue,  1 Oct 2019 13:35:57 +0300 (+03)
Date:   Tue, 1 Oct 2019 13:35:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] mm: Remove hpage_nr_pages
Message-ID: <20191001103557.rqjc2zkvhym4ntre@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-12-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:10PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This function assumed that compound pages were necessarily PMD sized.
> While that may be true for some users, it's not going to be true for
> all users forever, so it's better to remove it and avoid the confusion
> by just using compound_nr() or page_size().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
