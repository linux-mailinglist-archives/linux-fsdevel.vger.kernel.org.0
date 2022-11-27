Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F86639D49
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Nov 2022 22:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiK0V3x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Nov 2022 16:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0V3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:29:51 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B21FA1B8;
        Sun, 27 Nov 2022 13:29:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0FD126495E62;
        Sun, 27 Nov 2022 22:29:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DOUHMhrDNvOa; Sun, 27 Nov 2022 22:29:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ACF886495E7E;
        Sun, 27 Nov 2022 22:29:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FYpMhiFZPMSA; Sun, 27 Nov 2022 22:29:45 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 879AC6495E62;
        Sun, 27 Nov 2022 22:29:45 +0100 (CET)
Date:   Sun, 27 Nov 2022 22:29:45 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        chuck lever <chuck.lever@oracle.com>, anna <anna@kernel.org>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven <raven@themaw.net>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david <david@sigma-star.at>
Message-ID: <1045320558.283423.1669584585412.JavaMail.zimbra@nod.at>
In-Reply-To: <29d007755c6066552ac2a1b5bc498ce1ce28ab3b.camel@kernel.org>
References: <20221117191151.14262-1-richard@nod.at> <20221117191151.14262-3-richard@nod.at> <f31d4114f363ed9de0eba66ad6a730fe013896a6.camel@kernel.org> <1805608101.252119.1668719538854.JavaMail.zimbra@nod.at> <29d007755c6066552ac2a1b5bc498ce1ce28ab3b.camel@kernel.org>
Subject: Re: [PATCH 2/3] fs: namei: Allow follow_down() to uncover auto
 mounts
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: namei: Allow follow_down() to uncover auto mounts
Thread-Index: NMMtBM4gmoztCH6iGDr1qiHlAQw/TA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Jeff Layton" <jlayton@kernel.org>
>> So, in nfsd_cross_mnt() the follow_down() helper should use LOOKUP_AUTOMOUNT
>> only
>> if exp->ex_flags & NFSEXP_CROSSMOUNT is true?
>> Sounds sane, thanks for the pointer.
>> 
> 
> Yeah, I think so. I do wonder if we ought to make any provision for
> "nohide" exports, but since you have to enumerate those explicitly, it
> shouldn't be a huge problem for someone to just ensure that they're
> mounted beforehand.

TBH, I didn't invest much into the nohide feature wrt. NFS re-exporting.
What problem do you have in mind?

I wonder also what NFS client folks think about my changes before I send
the next revision (with Jeff's comments addressed).

Thanks,
//richard
