Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18BD3F59CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhHXIWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 04:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhHXIWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:22:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B3EC061757;
        Tue, 24 Aug 2021 01:22:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g13so43668961lfj.12;
        Tue, 24 Aug 2021 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zZwq+pN1VXh0KVPNvZvmvIYWYVH8kNxfn6jyHSUVlpI=;
        b=KFHgYjhqWZ+XExPs7OkTkgRUZWc184YLB3C7EPH0IRK4t3Vf27AIWDm4S3VsFdTgaL
         N/wbrR34Pq0GPen2jXaWbjO+1H7p6xGPNBj2dq1K4PXD/TfaqKDtA+nzxPTnVD2A369p
         iUtnacQVqYLsggBct+Haqoobg+JshRCTt2XHvVLfJF4G9Pn28KvMXO9Mj4CJ0v2Y80m3
         H91V8q17ghkFw7lXoujQb3//myxJ3FawLnsPjRdH9s9a1EcybLqwmVJENBty1+UJb4XU
         wcLx8rNYBvgY4o/XkM7cCcYWFY1/QZoa5ewTOkTcIjOgJyj7xEiYecbnBC9K1fFHcZ91
         r2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zZwq+pN1VXh0KVPNvZvmvIYWYVH8kNxfn6jyHSUVlpI=;
        b=lICfEwPZwflhmRQ/+tKyobZTlBe0+FqkeMQag1940SuG7v9EPUiol4cO1iHTjr+mck
         eocXoyTMbbp6O6lXTZ6eu5wbXm++lQJoJ+dXgqn/hzGTx7noF3BdYBJR75jGrzylMNrB
         dZYIL1dYzxiRh842QU0xzxtDwiUZAAkpQKJjX3ZqQYOU+QVYCeBiiQeadZXZquHPjWj0
         zKghOKySKJXyUbmbZYZT0WBDdBR6YZUH+edm8VqTh9Amsj1cshzvjt/avDG45rG4Wmde
         4hCopWfHwmoppLo8VQl14SUNDZPiz9TGKDlOavVvogn/1ZOnQtCDw2T2N/4fqV0JwtP6
         RGWQ==
X-Gm-Message-State: AOAM5309jyiMvvp7pMUnqeZGLiro/PmSZe4xDKMNZF/R46LLEC/7vZ7v
        OBFQpxo+aaHJb0Xuxs4ZAjc=
X-Google-Smtp-Source: ABdhPJyLyRhJ1eQfQW63C4umAP+Jx2W+GE/xefElm4Uk/uQgdb5S7TbW4Xbg2HhjaMyO4YIpldkMPg==
X-Received: by 2002:a19:4958:: with SMTP id l24mr27134681lfj.48.1629793319923;
        Tue, 24 Aug 2021 01:21:59 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id c10sm1705295ljr.134.2021.08.24.01.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 01:21:59 -0700 (PDT)
Date:   Tue, 24 Aug 2021 11:21:57 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 3/6] fs/ntfs3: Use new api for mounting
Message-ID: <20210824082157.umppqksjl2vvyd53@kari-VirtualBox>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-4-kari.argillander@gmail.com>
 <20210824080302.GC26733@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824080302.GC26733@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:03:02AM +0200, Christoph Hellwig wrote:
> > +	/*
> > +	 * TODO: We should probably check some mount options does
> > +	 * they all work after remount. Example can we really change
> > +	 * nls. Remove this comment when all testing is done or
> > +	 * even better xfstest is made for it.
> > +	 */
> 
> Instead of the TODO I would suggest a prep patch to drop changing of
> any options in remount before this one and then only add them back
> as needed and tested.

This could be good option. I have actually tested nls and it will be
problem so we definitely drop that. I will wait what Konstantin has
to say about other.

> The mechanics of the conversion look good to me.

I have made quite few changes to make this series better and will
send v3 in the near future.

Main change is that we won't allocate sbi when remount. We can
allocate just options. Also won't let nls/iocharset change.

