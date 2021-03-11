Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B23E337B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 19:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCKSC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 13:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhCKSCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:02:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AD2C061574;
        Thu, 11 Mar 2021 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oY8usOcU2tJQzURwngFZENfaB/DMt4vi1mHTJIPBgLc=; b=IiZigehimPn+ClF7nqAz8eEaju
        uJqrilt4zym+xkUWcVVPSTALVjD7YVv2HbJmizbrN/VHgLsQJzIjalAEJzcgpENqfYf0bxwPu8hnM
        sIVvZRntP9majtzJeQrK5/3hTVEhZ25q6lLgqYBcHix02/47iiX47saEHd4E5t/5NILLB4XYQVE30
        9a/FDukkQz0icUoJrLZPYZfBXmp8WNHaFLBbmz6qAHabxRlvZ+ToMOqN5foXg/Oho/eLXchZUPVKd
        1is+FnQKtKJMk1XQai6nhxaPoIAM2c6VuFIhoxg40kdfYuo8bLn1XmRVszGTnsFmEgE6EHHkS2RK6
        ZXVVriRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKPcN-0084yL-Qb; Thu, 11 Mar 2021 18:01:12 +0000
Date:   Thu, 11 Mar 2021 18:01:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>
Cc:     Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, smfrench@gmail.com
Subject: Re: [PATCH v4] flock.2: add CIFS details
Message-ID: <20210311180103.GX3479805@casper.infradead.org>
References: <87v9a7w8q7.fsf@suse.com>
 <20210304095026.782-1-aaptel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210304095026.782-1-aaptel@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 04, 2021 at 10:50:26AM +0100, Aurélien Aptel wrote:
>   mantics. The nobrl mount option (see mount.cifs(8)) turns off  fnctl(2)

s/fnctl/fcntl/

