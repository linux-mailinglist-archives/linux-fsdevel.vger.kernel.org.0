Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CDE5A67C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiH3P4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 11:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH3P4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:56:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28782B6031;
        Tue, 30 Aug 2022 08:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3E6EB81CCE;
        Tue, 30 Aug 2022 15:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D16C433D6;
        Tue, 30 Aug 2022 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661874998;
        bh=4MfZ2CCn8fhHH/Gt5iirr/AOGINTw9QezerOet2l08g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4kEIIWyxgOlguNNyyYoVWW9S5KnAAsJ+EbiyQQErMIK+stft/vi0m5cy1LomDk2L
         h5VpgDwrWcXRd4Kt0Zxcu2QUgkZMPebEozFNt2ciI5hxfGK3QTONM94Bj8y4E8W0sM
         qtONO/KZG8Gj4rAIvh084ZaWbp0KzPNvMyEkfPXcOXV9s+UfPa7REHR7Yq7sq5VSC/
         c7CYrs0CM8tDqKQ9StIutf7uJEc2kqU+da1fxdoD3dMgrpTIk7JWsIPNpn/gNfah2C
         nfj89MpvCJbSx2PXt9/k3zsgkUpcS5N1U6vsKmV8rNeKNQFs6rFZ+Y4VIwNRB6hra8
         PeEiQsd2EITXw==
Date:   Tue, 30 Aug 2022 17:56:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Guo Ren <guoren@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Wang Haojun <jiangliuer01@gmail.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org, linux-audit@redhat.com,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] fs/xattr: wire up syscalls
Message-ID: <20220830155622.4hcj6dka5jswydrg@wittgenstein>
References: <20220830152858.14866-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830152858.14866-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 30, 2022 at 05:28:38PM +0200, Christian Göttsche wrote:
> Enable the new added extended attribute related syscalls.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---

Fwiw, I think a while ago it was pointed out that for most syscall
additions you can just fold the hookup patch in. It probably also
wouldn't hurt to trim that Cc list significantly down to mostly the
lists...
