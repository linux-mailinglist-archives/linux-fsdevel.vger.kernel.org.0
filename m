Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2B5E9B98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 10:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiIZIGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 04:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiIZIF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:05:56 -0400
X-Greylist: delayed 719 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 01:03:18 PDT
Received: from mail.sernet.de (mail.sernet.de [IPv6:2a0a:a3c0:0:25::217:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718E5DFDC
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sernet.de;
        s=20210621-rsa; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+W/ndPBRDz87+caDzP+DTOgXQtcDbrXLmLMbuiXvpGA=; b=ty3qAWQTb0QMHfEuyp0QZUCDBu
        XKFAE1ahxtLCo/Szz/LbLomJdaxC1VTOU+wkJkqbc4WQSmtjmYuqnBKSK+jovEp7sag7renYoFCDJ
        ZW5x2P44j4jH85hPJ9F2jWB+2lqZf1IuGkSFtIFARommZi6c+4bY52tlwyorUwhTRB4ZjuFPHU1+T
        FK07UOgm1yKxDTGt59xoUgrrPvEenn7F7xmN+t67eYrHTbSAKe2Fyo75f9vVWQm3miZmLMFOwO1SJ
        pvshtpBfUJNp8JTzwk60Cep9V+CoJ7pPNd+6CxNVf0/qB1l6bak6WY0HzqwNXA3MrlJtLu6UeNojb
        NoYefDAQ==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sernet.de; s=20210621-ed25519; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+W/ndPBRDz87+caDzP+DTOgXQtcDbrXLmLMbuiXvpGA=; b=pVHmpNRRDYmqXsKHD/RE5zmdSI
        CQPJz5KTK7wojdGnL+V/5/yWAlR5QK/cGjo7LRGsBL0G+RR88qS3wPooARAQ==;
Received: from intern.sernet.de by mail.sernet.de
        with esmtps (Exim Mail Transfer Agent)
        for linux-fsdevel@vger.kernel.org
        id 1ocit2-00DJuw-A4; Mon, 26 Sep 2022 09:50:44 +0200
Received: by intern.sernet.de
        id 1ocit2-004les-1A; Mon, 26 Sep 2022 09:50:44 +0200
Received: from bjacke by pell.sernet.de with local (Exim 4.93)
        (envelope-from <bjacke@sernet.de>)
        id 1ocit1-0009Ga-9f
        for linux-fsdevel@vger.kernel.org; Mon, 26 Sep 2022 09:50:43 +0200
Date:   Fri, 23 Sep 2022 19:53:55 +0200
From:   =?iso-8859-1?Q?Bj=F6rn?= JACKE <bjacke@SerNet.DE>
To:     Jeremy Allison <jra@samba.org>
Cc:     Michael Weiser <michael.weiser@atos.net>,
        "samba@lists.samba.org" <samba@lists.samba.org>,
        Daniel Kobras <kobras@puzzle-itc.de>,
        "lustre-discuss@lists.lustre.org" <lustre-discuss@lists.lustre.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Samba] [lustre-discuss] Odd "File exists" behavior when
 copy-pasting many files to an SMB exported Lustre FS
Message-ID: <20220923175354.GA574247@sernet.de>
Mail-Followup-To: Jeremy Allison <jra@samba.org>,
        Michael Weiser <michael.weiser@atos.net>,
        "samba@lists.samba.org" <samba@lists.samba.org>,
        Daniel Kobras <kobras@puzzle-itc.de>,
        "lustre-discuss@lists.lustre.org" <lustre-discuss@lists.lustre.org>,
        linux-fsdevel-owner@vger.kernel.org
References: <CANdLGj4mSS8886V=29muKD7jGp35mmjN0t3zTWMJXzDB17a_cg@mail.gmail.com>
 <YkuqGFbxkYqZx8b7@jeremy-acer>
 <7b33d319236f44f2a500cda87ab87ea3@atos.net>
 <7aea59d5-6e9f-1131-0e60-295f94b9b154@puzzle-itc.de>
 <57ceac14486945f59a90cd88e6886c5e@atos.net>
 <YyyPfX7J2LKEI4QG@jeremy-acer>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyyPfX7J2LKEI4QG@jeremy-acer>
X-Q:    Die Schriftsteller koennen nicht so schnell schreiben, wie die
 Regierungen Kriege machen; denn das Schreiben verlangt Denkarbeit. - Brecht
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-09-22 at 09:38 -0700 Jeremy Allison via samba sent off:
> > So samba would need to take into account that not all filesystems
> > support extended attributes as a whole but might support some
> > operations on them but not others.
> 
> No, that way lies insanity and unmaintainable complexity in
> Samba. Blame POSIX (again) for not standarizing EA behavior.

sorry, but POSIX is not to blame here. NFS4 ACLs are the only standardized ACL
implementation. The is no such thing as "POSIX ACLs". POSIX ACLs have always
only been a draft. The draft was never finalized. All the UNIX falvours
implemented different draft version, this is also why it does not make any
sense to talk about a POSIX ACL standard here. Some implement for example DENY
ACEs, some don't. Some implement default ACEs, some don't. Some implement a
access mask, some don't. All of them are completely proprietary. In our Samba
documentation we still give the implession that POSIX ACLs are a kind of
standard. Honestly however, this is only the limited Linux proprietary version
that we document and implement.

All UNIX flavors (except for Linux however) support actually *standardized*
NFS4 ACLs. They were standardized by the same people to withdrew the previously
proposed POSIX ACL drafts.

I see more and more customers running into the limitation, that neither the
Linux SMB nor the NFS4 client implmentations satisfy their needs because NFS4
ACLs are non-existing in the Linux world and the management of NFS4 ACLs on
POSIX clients, even if supported server-side, is a pita. Frankly speaking, for
the majority of Samba fileserver setups actually Linux is no longer the
recommended platform. There is *one* good reason, why NAS vendors prefer
FreeBSD these days: the lack of NFS4 ACLs.

Björn
-- 
SerNet GmbH - Bahnhofsallee 1b - 37081 Göttingen
phone: +495513700000  mailto:contact@sernet.com
AG Göttingen: HR-B 2816 - https://www.sernet.com
Manag. Directors Johannes Loxen and Reinhild Jung
data privacy policy https://www.sernet.de/privacy

