Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766735B0EF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 23:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiIGVLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 17:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIGVLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:11:52 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84900BB010
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 14:11:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y18so11467906qtv.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Sep 2022 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BCFYG9/qxn8lVxwD6cqDmGQqlvy7uroaAgkV9Mai+c4=;
        b=Mf/9+B+xgp0UgWrVVVe/+dL5VOKDBsbbBJ90xaLhhgDlEffcuEPn0YFj5yff+57T/k
         xNSS3TDJfW2tM7JAy7hL489XQp2YhbKG9AmhK1obC8LuWi8BKRzk9siWClgnuCdpC+iq
         pw2rLjOyCEesItzr/g8MhTz9Q6QGTwGtbNThmPb7f16d1qrlCOBimptdUHesRZSjrvgM
         6tIJB9lqww16B52Y16gb7ql8eqsvP/GoVmbM7mg7yfWo2BODslaewdM3pdWTqUZYLBWD
         k/DwJKAo0dRESn1/KgkMysdyJUdmUItwIFGeGBToc9Y72547wdPWjIWE4svmD5pFIDtf
         Txzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BCFYG9/qxn8lVxwD6cqDmGQqlvy7uroaAgkV9Mai+c4=;
        b=8CW9xLZzvyMJI6oFYkZnNVFoYj/FfhFfrf7JJJ9RtTR5fafk3v846IpZWDQhK98MAS
         WETOcNB+tvsGxq43zDG6+eWA6b7RwlE0DdwqEWGj7u5/m9acONuROK4bn0G0jta6Ysp3
         kSrIOnGKjtcNEmSxhUyAC1XrRt5xhbE3V1+2UCS0+YK71dx9AjoZd8Wicbk5NhQBfE0Q
         gjW7S+2621R+p7qFsCQN3E32exKM+WRYdSxum6Yb9JmLyjjgENJw6UfajxZrH2Z0W/pJ
         9dMc3beDvQb/a2mpovfV9ICjP7rpQW2SuvZdBtFTTr2qhYfuOa9nsvey3NyvvyGM0VrJ
         Q5+A==
X-Gm-Message-State: ACgBeo1nax3BKg8J4SXG4AjnlzbSKvwbi91M/2yW5DJ8pim+ux84FYJ7
        O9YQNWXVQp6Z7/yfPzD+9ASzvA==
X-Google-Smtp-Source: AA6agR4RMOconEOYiWnnAocmU7yPShSSHn12U/sO2Ye9rYws/zbmXiRYZycUAP7jfEWP+blXpeBZpQ==
X-Received: by 2002:a05:622a:1348:b0:344:560b:2521 with SMTP id w8-20020a05622a134800b00344560b2521mr4917911qtk.525.1662585110603;
        Wed, 07 Sep 2022 14:11:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y5-20020a05620a44c500b006bb9e4b96e6sm17064095qkp.24.2022.09.07.14.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:11:50 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:11:48 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/17] btrfs: remove submit_encoded_read_bio
Message-ID: <YxkJFNTbdjtCFWOX@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-14-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:12AM +0300, Christoph Hellwig wrote:
> Just opencode the functionality in the only caller and remove the
> now superflous error handling there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
