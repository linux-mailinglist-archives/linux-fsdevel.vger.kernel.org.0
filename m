Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF73EBEE0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 01:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhHMXuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 19:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbhHMXuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:50:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2247C0617AE;
        Fri, 13 Aug 2021 16:49:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i9so2189265lfg.10;
        Fri, 13 Aug 2021 16:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6yFTZIaEgp5H00dOMerBFBCLeoc8spOxtK7FHqbj7Z8=;
        b=AOynv45tzmtsW0Bi2SASWB9SqD81av84eAjiWkLfpy1LS3wdZCCTAKknaAePocoWv0
         sTK7ReQ+KN+EqE4+e/aWycphoD/Ki9Sh1KqT0jUy7WDCmnJTY4TE/wVmNmuPkcGng/1h
         EaGZiG0e8CizEeZQPJuRyiF1zVb8lKPOuKGoMQzOScuGtJ338lxuk+K2Vb2KVhDscj0o
         ySeRr13j6ILkF2oQkkjdWKMnpyglZNGYAYmbgGsmZVqESDcObwsaXCR7oLcM6DJWqS6O
         Qf6nbyPCea5rcy98MkwoRDDdH5WR4OYn8PYBPtPR9EuU7ZgVu7See8jnuGozKWOgZF4M
         1iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6yFTZIaEgp5H00dOMerBFBCLeoc8spOxtK7FHqbj7Z8=;
        b=Z1xshl6UETD6ixNgpGeBENw/w05tJ/vVWCBpT5Ps1mIbqQchcEbEKmEsb2o6DQI3DW
         Oh3ezEO6hgu4m44KmYErs+tHladZGf3VcklHc5WV0XyjDR9C0W2S/OLSfBXvc3dsP/Zk
         GxRuHKCYpEsyYj2fmEYNSkaoSzwKPfqh/eX58TRej7/DVnZ38bebDcocym6sQjCz80CK
         a8n7CNj5kn7z42s7+C+loj2SMurQJZH28VuMicbPG/4lPIyg7pd932/rjkp1ePyXPC/X
         XPl6cX3DROZJnZJHuxggAP3Ek5A5/HgS3frrN6uaLgOPWnHCXQnd4bOlcywXrBRG9nI8
         8rxQ==
X-Gm-Message-State: AOAM533VKOF06EHhj4tQsLQRwIwFNpqzCIML/BqEiF/6eA2DXFXoN32n
        9GX49y2RNFSZIFjAutAXwak=
X-Google-Smtp-Source: ABdhPJyfzZ1Iq1e0y7zeNo0ac8SUpfcsVh6aK2rPlhPmD5Hsta9LcD2g3zz+E454DTpRZc31uXBucA==
X-Received: by 2002:a05:6512:398e:: with SMTP id j14mr3343870lfu.573.1628898590894;
        Fri, 13 Aug 2021 16:49:50 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id v1sm305584ljb.44.2021.08.13.16.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 16:49:50 -0700 (PDT)
Date:   Sat, 14 Aug 2021 02:49:48 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        pali@kernel.org, djwong@kernel.org, ebiggers@kernel.org,
        dsterba@suse.cz, aaptel@suse.com, nborisov@suse.com,
        dan.carpenter@oracle.com, willy@infradead.org,
        rdunlap@infradead.org, mark@harmstone.com, joe@perches.com,
        anton@tuxera.com, hch@lst.de, andy.lavr@gmail.com,
        oleksandr@natalenko.name
Subject: New mailing list for ntfs3 driver
Message-ID: <20210813234948.6b46jafsosgdoec4@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

New mailing list ntfs3@lists.linux.dev has opened. If you have any
intrest for this driver please consider subscribing.
https://subspace.kernel.org/lists.linux.dev.html

I have included cc list from ntfs3 v27 patch series and also ntfs,
fsdevel and linux-kernel mailing lists. If you think anyone else is
intrested please forward email.

