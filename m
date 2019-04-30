Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF81F2B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfD3JWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 05:22:42 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:44273 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfD3JWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:22:41 -0400
Received: by mail-yw1-f49.google.com with SMTP id j4so5349066ywk.11;
        Tue, 30 Apr 2019 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O71BR93nfVKV7X+BaaevcM23d4NroedovEN8YpLCNFc=;
        b=JcInW5rB9D8GUPZ8eanzEAStA6lvRQhboAjNfLzzLdXysYXomWALWwxj8+wTzvVYpa
         jLBy7vcbQaJD7mn8T5Sntys7faEG9YVKoEsGk7SwAh6x6cEYHNgmj8A2haTuJ+kyho0w
         ZloKwHb4U+H7rrb30t5RK0fyGo//KfIGrV7iYEYDfmnKtk/4nU3zTb2cnI0ux3hc2VF5
         MFyzzzTCYOA3bKMbJEnpkbcJGTbyxNno8ZMlD/MqkP3wKpg4r67bP3mhDMRpFThrIpcB
         tP9+3s8Xdq/IhNwAbwJJBEstIfHnp22w7/Kbmxgi5D9Ezmvu6/T0JG1EBV0Vwc/j2rrY
         X9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O71BR93nfVKV7X+BaaevcM23d4NroedovEN8YpLCNFc=;
        b=n/P08XTB0SjWLtHzLHFsDXCv6G+n4JNLH3uKGZdzQTUs5R6WRmenWTHoE3h9xbZBmd
         ACuAMCgOPEiNN3hWSKvy8hTIP9qW8T5n3fJi+Bu1t2BuOSS35e31RgMo4+GBPE5ZlXET
         RYmKqkxCLsmr1/1xi7VMsRxJyNDRCWN2Ws80IJLA0oY4bDKxHnTxc3b9cQUIOG2ZVCbw
         wPHBX064ddezedF+ZekUSVQfgmR2wnL5HTqrNcmBtKzhkVVq/eXuQqvUL8in9X1zetZW
         99VPNanzg/ByOCqQ669/c9OeNb6L62vxb+1223H6wckvynffpsLOeFpdU4uSV7S0DtXL
         Mktg==
X-Gm-Message-State: APjAAAU1hUQJlxQ1CeCB1145ig/fgGM6+Nux1Ie9WXQVeOq0cHB+37xi
        O7xeBWTSIO0m0BIF6QM45dQGlkzBS+QncnRYKXI=
X-Google-Smtp-Source: APXvYqyJZqlIcP4RcRxCE9J+CCDpDAOQezVG4wmzGr92TpdSb96QB+9P1jtwCzw83+ORzm1Cz6J4GtL1iisDo0MaJVw=
X-Received: by 2002:a81:1150:: with SMTP id 77mr54593542ywr.241.1556616160900;
 Tue, 30 Apr 2019 02:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjQdLrZXkpP30Pq_=Cckcb=mADrEwQUXmsG92r-gn2y5w@mail.gmail.com>
 <CAOQ4uxhuxoEsoBbvenJ8eLGstPc4AH-msrxDC-tBFRhvDxRSNg@mail.gmail.com>
 <20190426145006.GD25827@fieldses.org> <e69d149c80187b84833fec369ad8a51247871f26.camel@kernel.org>
 <CAOQ4uxjt+MkufaJWoqWSYZbejWa1nJEe8YYRroEBSb1jHjzkwQ@mail.gmail.com>
 <8504a05f2b0462986b3a323aec83a5b97aae0a03.camel@kernel.org>
 <CAOQ4uxi6fQdp_RQKHp-i6Q-m-G1+384_DafF3QzYcUq4guLd6w@mail.gmail.com>
 <1d5265510116ece75d6eb7af6314e6709e551c6e.camel@hammerspace.com>
 <CAOQ4uxjUBRt99efZMY8EV6SAH+9eyf6t82uQuKWHQ56yjpjqMw@mail.gmail.com>
 <95bc6ace0f46a1b1a38de9b536ce74faaa460182.camel@hammerspace.com>
 <CAOQ4uxhQOLZ_Hyrnvu56iERPZ7CwfKti2U+OgyaXjM9acCN2LQ@mail.gmail.com>
 <b4ee6b6f5544114c3974790a784c3e784e617ccf.camel@hammerspace.com>
 <bc2f04c55ba9290fc48d5f2b909262171ca6a19f.camel@kernel.org>
 <BYAPR21MB1303596634461C7D46B0A773B6390@BYAPR21MB1303.namprd21.prod.outlook.com>
 <CAOQ4uxirAW91yUe1nQUPPmarmMSxr_pco8NqKWB4srwyvgnRRA@mail.gmail.com> <677e86ee-59b9-0826-481f-955074d164ed@samba.org>
In-Reply-To: <677e86ee-59b9-0826-481f-955074d164ed@samba.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Apr 2019 05:22:29 -0400
Message-ID: <CAOQ4uxiwDPDyQPrPkUzZCO8jkySRiSK+AZu1dxppXvVA4q6XnA@mail.gmail.com>
Subject: Re: Better interop for NFS/SMB file share mode/reservation
To:     Uri Simchoni <uri@samba.org>
Cc:     Pavel Shilovskiy <pshilov@microsoft.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Volker.Lendecke@sernet.de" <Volker.Lendecke@sernet.de>,
        Jeff Layton <jlayton@kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 4:12 AM Uri Simchoni <uri@samba.org> wrote:
>
> On 4/30/19 3:31 AM, Amir Goldstein via samba-technical wrote:
> >>
> >> About O_DENYDELETE: I don't understand how we may reach a good interop=
 story without a proper implementation of this flag. Windows apps may set i=
t and Samba needs to respect it. If an NFS client removes such an opened fi=
le, what will Samba tell the Windows client?
> >>
> >
> > Samba will tell the Windows client:
> > "Sorry, my administrator has decided to trade off interop with nfs on
> > share modes,
> > with DENY_DELETE functionality, so I cannot grant you DENY_DELETE that =
you
> > requested."
> > Not sure if that is workable. Samba developers need to chime in.
> >
> > Thanks,
> > Amir.
> >
>
> On Windows you don't ask for DENY_DELETE, you get it by default unless
> you ask to *allow* deletion. If you fopen() a file, even for
> reading-only, the MSVC standard C library would open it with delete
> denied because it does not explicitly request to allow it. My guess is
> that runtimes of other high-level languages behave that way too on
> Windows. That means pretty much everything would stop working.
>

I see. I was wondering about something else.
Windows deletes a file by opening it for DELETE_ON_CLOSE
and then "The file is to be deleted immediately after all of its handles ar=
e
closed, which includes the specified handle and any other open or
duplicated handles.".
What about hardlinks?
Are open handles associate with a specific path? not a specific inode?

I should note that Linux NFS client does something similar called silly
rename. To unlink a file, rename it to temp name, then unlink temp name
on last handle close to that file from that client.

If, and its a very big if, samba could guess what the silly rename temp nam=
e
would be, DENY_DELETE could have been implement as creating a link
to file with silly rename name.

Of course we cannot rely on the NFS client to enforce the samba interop,
but nfsd v4 server and samba could both use a similar technique to
coordinate unlink/rename and DENY_DELETE.

Thanks,
Amir.
