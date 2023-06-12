Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4231C72B940
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 09:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjFLHyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 03:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjFLHxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:53:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55BE19BE;
        Mon, 12 Jun 2023 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D8FpkRq5Vb10qTbsqrdAgKkmstA2+5ca9T/rQFOuGlU=; b=JplKBdmZPYXjcKabwAGXGsrfEt
        jN+RFyHtpgISMUQV3AERKX80/H/h5+SW3S8a3EaqQj6fDGXDlXlRPziBH+50HKq2c0XZ4AktUyem+
        BF3Eoftpsn3uqLfGIoxiVw+IIvlKNHsUPhL/sYEnwBxYjAXrMazQBxnIV7s/XoI1fbi5gzf1wLDHW
        VFHAhktbqw6KZFAgZi1vn+CdN+Rd2fk519ru+Ds5vwFji6x68zu3BpSMlBwn+okqOYEIl86M9lU2E
        aM+JmICtD32m/5PUXXnRl/dxAcDnKyHmm6iA3EV69EwpEtGoMYkYMhnYoiB0Z50aNoaoEZYfNGUuq
        Of+UdKdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8b90-002mWI-2K;
        Mon, 12 Jun 2023 06:35:14 +0000
Date:   Sun, 11 Jun 2023 23:35:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 1/3] fs: rename FMODE_NOACCOUNT to FMODE_INTERNAL
Message-ID: <ZIa8olI/AuS6QTD2@infradead.org>
References: <20230611132732.1502040-1-amir73il@gmail.com>
 <20230611132732.1502040-2-amir73il@gmail.com>
 <ZIaelQAs0EjPw4TR@infradead.org>
 <CAOQ4uxhNtnzpxUzfxjCJ3_7afCG1ye-pHViHjGi8asXTR_Cm3w@mail.gmail.com>
 <ZIa3DfH9D0BIBf8G@infradead.org>
 <CAOQ4uxgQc3DivjAQNYhpDRZ5PA-wH1wSenoLkzYmFatueGJwUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgQc3DivjAQNYhpDRZ5PA-wH1wSenoLkzYmFatueGJwUg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:32:05AM +0300, Amir Goldstein wrote:
> Agree to both.
> As I told Christian, I was reluctant to use the last available flag bit
> (although you did free up a couple of flags:)), but making
> FMODE_OVERLAYFS overlayfs only and keeping cachefiles with
> FMODE_NOACCOUNT would be the cleaner thing to do.

Please go ahead with the bit.  In addition to the block series I plan
to move all static flags from f_mode to a new f_op.flags field in
the next merge window, which should help with avaiability.
