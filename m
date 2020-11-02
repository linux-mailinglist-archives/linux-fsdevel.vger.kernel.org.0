Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE42A34E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgKBUI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgKBUGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:06:46 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F50CC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:06:45 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j62so10124512qtd.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 12:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F2PqZxAO2LkDVNKGoWf5Pkxul4tgZGhDqkaMXwRTbxY=;
        b=Cmpoq2/2ogkWhJIf9Xy9uamigjtVQGLD7RFLYWDDlJZY+iePEJf8tlZxjmQxmhZDZ/
         y10tuHYmqRf2h/M6i/AEnic11dlSVeoGH9BSmQuMQQpf6RlUEEMZm3tA60aeUxLjK6GV
         zeH7dHp9nk8jxOtd9L5wGvYAdpazNAoEdkdf0VymOTLz+yLNMtyD6wu5JDz5qUfdko9S
         54luWq18zTzUi96WqY/wC6iwOK3Xph3UgSskOC/iqIFOpH0dQmGSD3SeCqwmEs2/h7ap
         6ATupn8g6AvPznO6wGSbFLNE2jR7NEpuxAlSNlVAEYbf+1AU4uun6PWMxjUSrQwjQ+3X
         RQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2PqZxAO2LkDVNKGoWf5Pkxul4tgZGhDqkaMXwRTbxY=;
        b=KEXdgZ5mhyPkXnrhLfrrC4sXbE/Td3AeA5to7cp/V7SXHRWqs9xUX/uBj0idEoi75k
         dkPCVCS6Erkctd5zAthcR7hwYIGNtQsdJiX1blnDuhWCrSZsspvl3RZslyFUt8TXxitK
         NNIXCpPl/rG6rJmvvhVdeDUqEqB4ERJyDv+s8+oKDwboPxE/VDnxd+qIKsSc5y38OKpg
         mhGH1l998Odwh02mOQ2UbNLhtf23vmdEK4h/lo0GUYU8mPrefbsuWFRnm/IrDelj4HWz
         /DJ8qwQW/Vz0Gxyzi1vlpPzI5IvN29FAF6Opb2HtCY5zL02bb91fQ7U+y7BqjIWe/Msx
         Ngzw==
X-Gm-Message-State: AOAM530bumRyPrLjcPxw4xpOajG+SnA899KNK8kiiaq8vj4P7dBcxI8Q
        2L11sNuuFvN1Qdk+JIPEUQ==
X-Google-Smtp-Source: ABdhPJxUiDE448GOg+pXcOcTkeWM2emIz7FIgBAFxWuBUxWsCpbAvpvkiwp4GZRn1K1wFfpX+NQUSw==
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr15487179qtu.337.1604347604645;
        Mon, 02 Nov 2020 12:06:44 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n127sm7034781qke.92.2020.11.02.12.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:06:44 -0800 (PST)
Date:   Mon, 2 Nov 2020 15:06:42 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 16/17] mm/filemap: rename generic_file_buffered_read to
 filemap_read
Message-ID: <20201102200642.GT2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-17-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:11PM +0000, Matthew Wilcox (Oracle) wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Rename generic_file_buffered_read to match the naming of filemap_fault,
> also update the written parameter to a more descriptive name and
> improve the kerneldoc comment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
