Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CE658A109
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiHDTDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 15:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiHDTD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:03:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7194F6D9CB;
        Thu,  4 Aug 2022 12:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE1BF616C2;
        Thu,  4 Aug 2022 19:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C97C433C1;
        Thu,  4 Aug 2022 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659639806;
        bh=X7SaZV8NQYFASqG1eXvSDJ7c73ijas8hXeL+BClnemQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WUY/8Ckxx+AsFlgt80MLBv3NCXV9f7cIh/nqssiOjPAqpQHGJ4eElZ4F6jqqn6az4
         JkS1m8vkuGjssI3FX9Y4LL5ZXWLFOluw4CYz29z1FB6zpeW6LpS4w2lVGX3uNZlQk+
         W/azQHgk3I6TatLgVaMr8GP6YMBGUn6uDBAeYmz8ZU7Dd0aMI33w7eFSDAwPLA4Mi/
         d0fck0RxnUIFs5N6W4Ff5febReOhje5PkxF7UEeorYXkzb/bEg1ELOltMNLoRxfwOX
         IdWmiM6scwlj/IoILvwNb1J8MIu9bue89EBqmkrh9ow5VGRT1mLck9vw2febnfVuMW
         XVwy98XYMZWig==
Message-ID: <cf24d6b5496598e7717428c6bdcb2366a7d49529.camel@kernel.org>
Subject: Re: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
From:   Jeff Layton <jlayton@kernel.org>
To:     Enzo Matsumiya <ematsumiya@suse.de>, Tom Talpey <tom@talpey.com>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        samba-technical@lists.samba.org, pshilovsky@samba.org
Date:   Thu, 04 Aug 2022 15:03:23 -0400
In-Reply-To: <20220803015655.7u5b6i4eo5sfnryb@cyberdelia>
References: <20220801190933.27197-1-ematsumiya@suse.de>
         <c05f4fc668fa97e737758ab03030d7170c0edbd9.camel@kernel.org>
         <20220802193620.dyvt5qiszm2pobsr@cyberdelia>
         <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
         <1c2e8880-3efe-b55d-ee50-87d57efc3130@talpey.com>
         <20220803015655.7u5b6i4eo5sfnryb@cyberdelia>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-08-02 at 22:56 -0300, Enzo Matsumiya wrote:
> On 08/02, Tom Talpey wrote:
> > The initial goal is to modularize the SMB1 code, so it can be completel=
y
> > removed from a running system. The extensive refactoring logically lead=
s
> > to this directory renaming, but renaming is basically a side effect.
> >=20

This is a great technical goal. Splitting up cifs.ko into smaller
modules would be great, in addition to being able to turn off smb1
support.

> > Stamping out the four-letter word C-I-F-S is a secondary goal. At this
> > point, the industry has stopped using it. You make a good point that
> > it's still visible outside the kernel source though.
> >=20
> > It makes good sense to do the refactoring in place, at first. Splitting
> > the {smb1,cifs}*.[ch] files will be more complex, but maybe easier to
> > review and merge, without folding in a new directory tree and git rm/mv=
.
> > Either way, there will be at least two modules, maybe three if we split
> > out generic subroutines.
> >=20
> > Enzo, you're up to your elbows in this code now, is it too ugly without
> > the new directories?
>=20
> Having things in separate directories and code appropriately distributed
> in coherently named headers/sources certainly makes things easier to
> work with.
>=20
> Of course this patch is not important, by far, but from what I
> gathered, it was some people's wish to move away from "cifs" name.
>=20
> Answering your question (IIUC), Tom, I'm ok with postponing this change.
>=20
>=20

Cool. I'm not even really opposed to moving the directory to a new one,
but I think a change of that magnitude ought to have some clear
technical benefit. Maybe it'll look more palatable once the breakup into
multiple modules is in place.

--=20
Jeff Layton <jlayton@kernel.org>
