Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F305B0F07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 23:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIGVSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 17:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGVSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:18:23 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEE1BB6B3
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 14:18:22 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x5so11456391qtv.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Sep 2022 14:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ccv4AZF67qfvGo9/wiqF1Tt0hDx5b58CTNzLj9RUb44=;
        b=Ae2Xcoy3LQubNC6wHclSN5w0aBovADD56pO/Hy0hPCHHoHUYFBPv0GWtU6oN2xi/c+
         St+DlFOyoQIjZ8JhJjtPr1xHAHhruW3EI6QORJeBmQWVkWF1Flp1fJlOG9Br/JWfHF8I
         G8sxVNdiW1IeZdrGhcyZDsgNZYPujwIDVpQK1zYDDBcEZMTLmSUa+zy1pfuvuEpdPGDC
         3bOLXmIadjWQFEc9Bc0zttmYcjjYv9C2JY8k1Vj+VSHydJW4/bnfHpwr9ILsYqZ2DKi6
         m8jNqebiF7CmI1rk0cXu3c+2tGbFqgZ45dFofZwXOF5iBIVOHRTL+y1UitueA2opVzPx
         1gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ccv4AZF67qfvGo9/wiqF1Tt0hDx5b58CTNzLj9RUb44=;
        b=RQlGmP5Jw+spiw0pvZpmj72q1O/EOje5jyiQYK35+sj/ftKuQdTN7enoCk0ars5iay
         uG60sxD6Z2yvgB1lUom3r0YZP4Zl4L6Tci+Bg7287KjPd05K9M23IhHvcOMRajcVDynI
         P96mfxt4wJv6La2ivRrsXXJwVzYEQMOQMCjZwtPncwSX6lXruRacNrgD6aIKMw+ki8kY
         0X5XO8z7GifPyDiSVKYxBIPCHOIsbYm/0EX6gbALVkPJbSFAa86t4R64209pP+cVwU+G
         SGkrxlyJIcA3pKax1yxlgthSxxhaUlM7lg0DnZGhnd68W1UkBeU12uqEzEcXdUcpMaaV
         e0jw==
X-Gm-Message-State: ACgBeo3nvmJRH/xR3/cyRDlgM7ZyqLZyvQD/dXKjx2Bn88mizewQ/JoY
        Ex8S31B1GQQJUUKBRLQdAOImZQ==
X-Google-Smtp-Source: AA6agR566GOqz4tuQIA9B/tKUGP8r7l6ITR8tHgUym12oYdmjg5tTBx3oG8Sodf4Q9iAVQuOIBN3Ww==
X-Received: by 2002:ac8:7dc1:0:b0:344:6104:eab6 with SMTP id c1-20020ac87dc1000000b003446104eab6mr4941912qte.455.1662585501724;
        Wed, 07 Sep 2022 14:18:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n76-20020a37404f000000b006baed2827f2sm14480098qka.44.2022.09.07.14.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:18:21 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:18:19 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] iomap: remove IOMAP_F_ZONE_APPEND
Message-ID: <YxkKm2PYRDy/DUXy@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-18-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:16AM +0300, Christoph Hellwig wrote:
> No users left now that btrfs takes REQ_OP_WRITE bios from iomap and
> splits and converts them to REQ_OP_ZONE_APPEND internally.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
