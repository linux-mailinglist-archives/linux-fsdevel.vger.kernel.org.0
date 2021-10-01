Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909B841EC93
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354128AbhJALww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 07:52:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52666 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhJALwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:52:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DAB4C1FEB1;
        Fri,  1 Oct 2021 11:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633089066;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPmeCBZSsYiLLfE1gc8X3jw7ygoQiw9almXBGbHz3tQ=;
        b=00RthduatWEqBKd3r2KndVa2KFmBS2JY0Ys5ezPz2jQVJpfFQjdviOR7rtLERL53nmoR5X
        gqHpCZcSsh/htYz22d5jtTig/Xrx1fXqxWahgcdZTicJ5eKLQuFRAxUjmHyp/fqZxXaJ5w
        AS5ju+p2Px1JIin9zRd/DbcTDumzQQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633089066;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPmeCBZSsYiLLfE1gc8X3jw7ygoQiw9almXBGbHz3tQ=;
        b=iljZD///wzN5tI7a5lINsRbcqqBOUpXqUuDdzjp+C3R/t35jwolMeKzgmdA0i3R2+VprAI
        a4lPaEefxsLmBBBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CD4B6A3B8A;
        Fri,  1 Oct 2021 11:51:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF3D6DA7F3; Fri,  1 Oct 2021 13:50:48 +0200 (CEST)
Date:   Fri, 1 Oct 2021 13:50:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     David Sterba <dsterba@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/affs: fix minor indentation and codestyle
Message-ID: <20211001115048.GS9286@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211001002702.151056-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001002702.151056-1-sohaib.amhmd@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 01, 2021 at 02:27:01AM +0200, Sohaib Mohamed wrote:
> Errors found by checkpatch.pl
> 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>

The AFFS driver is in fixes mode so pure coding style changes are out of
scope. In case you'd fix a bug a need some refactoring then it's fine to
fixup the style and do non-functional changes but otherwise it's not
worth the effort.
