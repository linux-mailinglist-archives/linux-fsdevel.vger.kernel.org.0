Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC47268AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 20:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjFGS1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjFGS1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:27:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2412689;
        Wed,  7 Jun 2023 11:26:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9788faaca2dso51915966b.0;
        Wed, 07 Jun 2023 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686162395; x=1688754395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wODPx4uHZJHUTcdDegTDGQs4CeriK253kkjDqRsBvLs=;
        b=PgvSlIT79OUd63jjASsNr92npBtidqBIIcr0/yPjJPwrQ/113jrShII9sGfjwbYNb3
         bf1Erx4stn1BnaSvp0QRn3qhoAelcgpWg10/cZdcHU39eWCQ1zmmvFhsHckWl6Mpelo8
         UrQi0n95qJH0NgcaprsRqK9EsuGGixeScoDOcZNRWhXrxGCKSJJrifQbQDpJ/NbpAVeB
         jnMpK7MSMrzR6/c7dXnHLdH4Ep23xmPbYZOWN/75YGet+B2gqilLbPZb2Wn5na98SVuI
         dVofyri9mYj/d28wmhB/SlSfcRQFKI3N6FrMTeZxK3M2g2XCX1xe1Rxen17YsRLYapOG
         aV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162395; x=1688754395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wODPx4uHZJHUTcdDegTDGQs4CeriK253kkjDqRsBvLs=;
        b=evbCRQMJycX8FynDaH3KXyLrxisnPmIji7KFkTBnHmIEZTxPqKnEcWCV3pS43qBLkX
         dSIlglmkYco9TtVl/VFPJ4bSMFFrmI9N5p3ExG1B2CgYm4j/9V5lZ1YuQmEuVzmggcCB
         g84bRRhfv14k7wdReT1nenavAbmVwyPXl6pU8yi34ar5pUmm+Dn2YOSVK1Yho+QFp+OJ
         JYflemTWZESyDUOCchdJUe+78VBY1wPEQ7+v8zxAUfJK9vngxfBgqq8bhy9uujz5SjB7
         StMYy3mSYLM0uJzlKbdH21g8F5zHxoX5oZwopo83vuyFPmZPqUr5uF5IU+9W9od+xmWu
         fSSg==
X-Gm-Message-State: AC+VfDwjS50lfhjqlv1VINVtq+8v6+PtGAfQ8jVkxH19y79q0gBvt/43
        jY4QkUYzKCmm/h+QXVZCg/oAG9iYuX8XOgxGWj0=
X-Google-Smtp-Source: ACHHUZ4gkb4uXmtBfRalz/8gTBT4f6/AWlotdJNjgnU0y7BmJ/z28Vm/frajygWJFDgVS+dJ1qAf3w6FaHOtUUKNuBY=
X-Received: by 2002:a17:907:2d2c:b0:977:c8a7:bed5 with SMTP id
 gs44-20020a1709072d2c00b00977c8a7bed5mr7336385ejc.47.1686162395234; Wed, 07
 Jun 2023 11:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230216150701.3654894-1-dhowells@redhat.com> <CALF+zO=w2Gyz6JtzEoFgTVjH67-_CuTaK7e+2yoHEwXZ8bPx_A@mail.gmail.com>
 <CALF+zO=Y8dMsJ79RYp1e7n9B5_0=segpqW9_tetBqPhFiQcZxA@mail.gmail.com>
In-Reply-To: <CALF+zO=Y8dMsJ79RYp1e7n9B5_0=segpqW9_tetBqPhFiQcZxA@mail.gmail.com>
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Wed, 7 Jun 2023 19:26:23 +0100
Message-ID: <CAAmbk-cBJprmRsW5uktAm49NtVw9WTLA=LPS7uLkwAknjs_1qA@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH v6 0/2] mm, netfs, fscache: Stop read
 optimisation when folio removed from pagecache
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     David Wysochanski <dwysocha@redhat.com>,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Any update on this? I assume it's too late for these patches to make 6.4.0.
