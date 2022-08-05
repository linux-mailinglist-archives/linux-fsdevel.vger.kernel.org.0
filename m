Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE6B58B0A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbiHEUAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiHEUAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D09DE5F;
        Fri,  5 Aug 2022 13:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7FCE61A02;
        Fri,  5 Aug 2022 20:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAC9C433D6;
        Fri,  5 Aug 2022 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659729612;
        bh=i34KpvdFHHe7YrZHKr55abPcKB4K2b6UnHu2ZsN87YA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SGzW6bC231TCU7f9FLpE7fDEEGNPz0SnBktqMLmC7eI+P2EMq/0kPDWsUMJL/vxyn
         x6u/qBTBeKCO/KUwWzloTxrbTr/gC4n4UlcFizASMUc2F67WzO5ksJX09jLz6yxcjK
         anYRXB+I4Okwv9c8IvkTGTnYGzHM7xnKbX1iYfDHpVeypABOXMvJpy9TSs4BsGrhtq
         AFzRfruO3y29wFtGX5i1BHHDDor3ToU4PbIHJG5GP01IOA94x0rFDFmIAfNadukrtT
         SlShzPyTYogDGJITQjA1qEaBOM0/q4UebXP2z991PoNcttfOMYAJg2KmWWUcaktWlC
         1EaX09SgBTXFg==
Message-ID: <350a119fc754f99aeada313782f3cd5e67cf1740.camel@kernel.org>
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, lczerner@redhat.com,
        bxue@redhat.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Fri, 05 Aug 2022 16:00:09 -0400
In-Reply-To: <3731056.1659727021@warthog.procyon.org.uk>
References: <20220805183543.274352-2-jlayton@kernel.org>
         <20220805183543.274352-1-jlayton@kernel.org>
         <3731056.1659727021@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-08-05 at 20:17 +0100, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
>=20
> > +	__u64	stx_chgattr;	/* Inode change attribute */
>=20
> Why not call it stx_change_attr?
>=20
> David
>=20

Ok. I'm open to suggestions on the naming in general. It's a small
patchset so it's not hard to change that.
--=20
Jeff Layton <jlayton@kernel.org>
