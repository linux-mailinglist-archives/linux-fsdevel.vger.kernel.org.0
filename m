Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7751D768EB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjGaH31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjGaH1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:27:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A801FD6;
        Mon, 31 Jul 2023 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KJOxcqJt/auWhGgw55NsCZuSDH/zfl2Bfbm5nTrd8NI=; b=MRVSS7BTJpcYYG01PhTNrysfey
        AAPmqJrjOPgjul0tC8EDK1jyvziejlnJEBdBa4r1VIzQOhzVKuJbvjZWHDwNGGWSOY3F3+CQOsPIp
        rNqIueY4vDu1WaGgDtKQHeV1zxlphQh+p+KIqO92dzEEcpwhlTjvHC2MaOAfXBrH3QtEwdJfRqKpu
        N88/9nIbjxV66Lu0HRANpMhUJzttJsFp8EkgOFAq8S+A40QT/ZtAQVY2SmVriW8PYq44kkefIY89E
        yx76Piao/8kvCpJlOJLwJtVv64vjSMLr6c/YEMTjgmsAlCjvgUArgFBJZUb7PfWTPRFjdojXmaYo4
        VfH3n2iQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQNFI-00EJ3Z-10;
        Mon, 31 Jul 2023 07:23:12 +0000
Date:   Mon, 31 Jul 2023 00:23:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bill O'Donnell <billodo@redhat.com>,
        Rob Barnes <robbarnes@google.com>, bleung@chromium.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: export emergency_sync
Message-ID: <ZMdhYGKvED9IVP4c@infradead.org>
References: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
 <ZLcOcr6N+Ty59rBD@redhat.com>
 <ad539fad-999b-46cd-9372-a196469b4631@roeck-us.net>
 <20230719-zwinkert-raddampfer-6f11fdc0cf8f@brauner>
 <ZLeDVcQrFft8FYle@infradead.org>
 <ZLhMzQWUS0htHEdb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLhMzQWUS0htHEdb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 01:51:25PM -0700, Dmitry Torokhov wrote:
> I am not sure why you would not want modules to use it - in the case we
> have here we detect a catastrophic failure in a critical system
> component (embedded controller crashed) and would like to have as much
> of the logs saved as possible. It is a module because this kind of EC
> may not be present on every system, but when it is present it is very
> much a core component.

I really don't think this is a kernel poicy in any way.  Please do
a userspace upcall and let userspace deal with the policy decision.

