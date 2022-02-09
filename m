Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932ED4AFFC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 23:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiBIWAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 17:00:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiBIV7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:59:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EA1E00D131;
        Wed,  9 Feb 2022 13:59:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A2A001F391;
        Wed,  9 Feb 2022 21:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644443994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+pQpKmfzlL4KZk9ukchLsiAEhY7uRcrMQ98+/U4mU0=;
        b=eKSAQfQCWZPpF8fWc7728iUVKDG/8xR98p8nDijBvNvt52pynaLXqeR6sY965pMDlBeCSh
        y47AGd3E19xzvuYK3hmsDY2vyt8q82lsVhZ1yLRek+hq1U7Q9GqSagKaUoKQprx2Og5o1X
        P0UXuWCIwOPdupwNPVBjFWKy+D0lNzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644443994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+pQpKmfzlL4KZk9ukchLsiAEhY7uRcrMQ98+/U4mU0=;
        b=aTjHNUkIup75+LiMJuwnyqbqEqC8SAf4w30ZJjgGNhYFY3PSAwLywS8ZNNRUw+IYYeC5oZ
        OoIds/Y2hxOgKbCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31A2113A91;
        Wed,  9 Feb 2022 21:59:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UF+yN1g5BGKWMQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 09 Feb 2022 21:59:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Ian Kent" <raven@themaw.net>
Cc:     autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
In-reply-to: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
Date:   Thu, 10 Feb 2022 08:59:48 +1100
Message-id: <164444398868.27779.4643380819577932837@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Oct 2021, Ian Kent wrote:
> Hi all,
>=20
> It's time for a release, autofs-5.1.8.
>=20
...
> - also require TCP_REQUESTED when setting NFS port.

Unfortunately that last patch is buggy.  TCP_REQUESTED is masked out in
the caller.

Maybe the following is best.

NeilBrown

From: NeilBrown <neilb@suse.de>
Subject: [PATCH] Test TCP request correctly in nfs_get_info()

The TCP_REQUESTED flag is masked out by the caller, so it never gets to
nfs_get_info().
We can test if TCP was requested by examining the 'proto' parameter.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/modules/replicated.c b/modules/replicated.c
index 09075dd0c1b4..3ac7ee432e73 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -291,7 +291,7 @@ static unsigned int get_nfs_info(unsigned logopt, struct =
host *host,
=20
 	rpc_info->proto =3D proto;
 	if (port < 0) {
-		if ((version & NFS4_REQUESTED) && (version & TCP_REQUESTED))
+		if ((version & NFS4_REQUESTED) && (proto =3D=3D IPPROTO_TCP))
 			rpc_info->port =3D NFS_PORT;
 		else
 			port =3D 0;

