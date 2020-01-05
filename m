Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B79130958
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 18:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgAERvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 12:51:51 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35304 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726264AbgAERvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 12:51:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 65EF08EE148;
        Sun,  5 Jan 2020 09:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578246710;
        bh=/O6Z8BsHvMh2UwSigtzUiEUL2QF8ER/Ca7tLjhwe1gU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aElfaH19GG+9IjOoiUPIuwr6JLgxu1Kjexya4e3mPsVS/S74hZqKDnFUu95lQx8Rp
         FxvrBE3Wg4yde/wZPiU9sNSaEeRapERExtD1QkgpkNNgcoH7XFJ+/mS314doXqEBKt
         ZJVZLeNwAVU9cD2eeEcuG96HooYv0JVmT41IrwMY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8dO8nz5S8QMX; Sun,  5 Jan 2020 09:51:49 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C14A68EE0D2;
        Sun,  5 Jan 2020 09:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578246708;
        bh=/O6Z8BsHvMh2UwSigtzUiEUL2QF8ER/Ca7tLjhwe1gU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=egM4zJiHW8UGSohp38WGLq9JUxFtIIyNAnAsiVEWcdsmPej3ehiBN/JZE7y0VbylL
         cfK4ynZpTGN9VA6SbmaTo7uEYt/o6/lhQjGbAZW4TO/D8Eexsa8k8Q8wONjWhK3DRF
         2MuRcMq4B3vK35tB/mEPFO4exroFClc3C6OApSF0=
Message-ID: <1578246706.3310.28.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/6] introduce configfd as generalisation of fsconfig
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun, 05 Jan 2020 09:51:46 -0800
In-Reply-To: <20200105162311.sufgft6kthetsz7q@wittgenstein>
References: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
         <20200105162311.sufgft6kthetsz7q@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-01-05 at 17:23 +0100, Christian Brauner wrote:
> So I have strong reservations about configfd and would strongly favor
> the revival of the original fsconfig() patchset.

Just so I know what I'm replying to, what is the "original fsconfig()
patchset"?  I simply based configfd on what was upstream ... I couldn't
find much discussion in the archives about precursors or original patch
sets, so a pointer would be very much appreciated.

James

