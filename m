Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB56244B11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgHNOJB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 10:09:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:54788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgHNOI7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 10:08:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A285ADA3;
        Fri, 14 Aug 2020 14:09:19 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: NTFS read-write driver GPL implementation by
 Paragon Software.
In-Reply-To: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
References: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
Date:   Fri, 14 Aug 2020 16:08:53 +0200
Message-ID: <87mu2x48wa.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Konstantin,

That's cool :) As Nikolay said it needs a little change to the makefiles
to even build.

Are you also going to publish your own mkfs.ntfs3 tool? I dont think the
existing one would support 64k clusters.

I would recommend to run checkpatch (I see already 87 warnings... some
of it is noise):

  $ ./scripts/checkpatch.pl <patch>

And sparse (I dont see much):

  $ touch fs/ntfs3/*.[ch] && make C=1

You need a recent build of sparse to do that last one. You can pass your
own sparse bin (make CHECK=~/prog/sparse/sparse C=1)

This will be a good first step.

Have you tried to run the xfstests suite against it?

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
