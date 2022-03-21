Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB04E346D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 00:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiCUXel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 19:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiCUXeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:34:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EBD5577D;
        Mon, 21 Mar 2022 16:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=8INTyMSFBrX1EJ+aoDBL+ySWd7+IvZDAvs379S+ikME=; b=aLSfJs7R8GRGCLwR+bJOKO7Nb6
        F1TSYPL+zA2r9J2yLcffA10yBBQtSQ/upF+xpW42/Dj7ELLUpNckJZOD4TZWcRsKE7ArM0todtkWu
        7GCW7VJkm2+VgQH5SZbXxNVxSGyOZd3dwOveQS8LL/a5lRRXqqrJEhemc7yua2+Ob3AgEu5U1kala
        7QuJPq1NQSEj6dSqpnDmPU/KScnYham+fku06RDaxWBwE4Uvrzd0QDr7TC6VIkRj95pD6brp+J+EC
        2wLcn5Z61YHDkP+7h+1FC+b2BpEQzKaZxZZvxTNF2OizXmjcw2UzGny/zBNsa81dIucRheCCYASEn
        8j2FNP6Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWRW7-009QAL-Q6; Mon, 21 Mar 2022 23:32:51 +0000
Date:   Mon, 21 Mar 2022 16:32:51 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
Message-ID: <YjkLI4D+ek9shkqL@bombadil.infradead.org>
References: <20220321161557.495388-1-mic@digikod.net>
 <Yji3/ejSErupJZtO@bombadil.infradead.org>
 <cfa15768-ebf4-d198-fb1b-5a6ab47caedb@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfa15768-ebf4-d198-fb1b-5a6ab47caedb@digikod.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 07:05:42PM +0100, Mickaël Salaün wrote:
> 
> On 21/03/2022 18:38, Luis Chamberlain wrote:
> > On Mon, Mar 21, 2022 at 05:15:57PM +0100, Mickaël Salaün wrote:
> > > Since I heard no objection, please consider to pull this code for
> > > v5.18-rc1 .  These five patches have been successfully tested in the
> > > latest linux-next releases for several weeks.
> > 
> > >   kernel/sysctl.c                                    |   9 +
> > 
> > Please don't add more sysctls there. We're slowly trying to move
> > all these to their respective places so this does not become a larger
> > kitchen sink mess.
> 
> It is not a new sysctl but proc_dointvec_minmax_sysadmin(). This helper is
> shared between printk and fs subsystems.

That should be good then, thanks!

  Luis
