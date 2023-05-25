Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4991B7117B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 21:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbjEYTwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 15:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbjEYTwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 15:52:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB88186;
        Thu, 25 May 2023 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D7NQmRuqfIsEVR83BVLhsz0LP5kJifZlCo3sFrhILyA=; b=RbmZ2COJ0hOjRehG14J87kDkCi
        MHCwALzarsaHHrZifIhnzjBtS5ICNh0Dpx01/0rzkQt5UHRlDdncz2xyvRRg4hiCtzr3dZ5/aQP6g
        TCOlcRlB7CRYm/N7wHEHzGG+3tpBPmVxPLSkKrgtjKnr87P+VrpYfMn4fYFcShV+DM9jxv2XrhrFr
        EQ7XVYTflbx7l3tiuzgd1gzn5uo7n71cHoSAunqtJlwJaEW7IVWFIQNBk57qUNaUp0Y+easuXgzme
        zFP/KaSD2jxjzd871VCfrlgs+iTR26KC1DVufH+43lQ1cekF9VoVwx9QmRZ4+OMn4yH8WWWDZA3+x
        CKtoNQdw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2Fxt-00HTHf-00;
        Thu, 25 May 2023 18:45:33 +0000
Date:   Thu, 25 May 2023 11:45:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        arnd@arndb.de, bp@alien8.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, brgerst@gmail.com,
        christophe.jaillet@wanadoo.fr, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, j.granados@samsung.com, akpm@linux-foundation.org,
        willy@infradead.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] signal: move show_unhandled_signals sysctl to its
 own file
Message-ID: <ZG+szFEwbwh6lB9I@bombadil.infradead.org>
References: <20230522210814.1919325-1-mcgrof@kernel.org>
 <20230522210814.1919325-3-mcgrof@kernel.org>
 <d0fe7a6f-8cd9-0b81-758a-f3b444e74bab@intel.com>
 <ZG29HWE9NWn56hTg@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG29HWE9NWn56hTg@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 12:30:37AM -0700, Luis Chamberlain wrote:
> Let me know!

Re-poke. I know, it's just been a day :P

  Luis
