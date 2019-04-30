Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAA4EDE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 02:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfD3Abu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 20:31:50 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37678 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbfD3Abu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:31:50 -0400
Received: by mail-yw1-f65.google.com with SMTP id a62so4674114ywa.4;
        Mon, 29 Apr 2019 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/yRQPse6qS5n8TwGMMfaxf78MZP/YYbhh3nzkAxoqD0=;
        b=nUbFDxlX7P+MGSwjh2h1pJhMarECOfxLV/jnEspOYDRCpnOkHyhWg8kK1htkE1vp+c
         mvh6nES0Aux9txy9fIfcm+IcfAsdttXfETuHHned0k1ON/qCcbFPtQozYs2XeAENR5bZ
         SmYTm0BTZ5XWhpt8ffkcMXFhC2QaHD3ke3MrktOOxWsbcgcTymow3xGTqlvHecVNp0yW
         qZ43W8vL03MefSYGoKprDYMz8CcdGAG5fT/An+I1aISNbSRvsUo+yGHeneNBfT8eINdW
         pkyo5AsklDKDgmbKFTVbIJC35qZTtjOykVJah3CwAI9SyBS2QfArs79EhEHxmwlJ2pMU
         0v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/yRQPse6qS5n8TwGMMfaxf78MZP/YYbhh3nzkAxoqD0=;
        b=ELZ8Xw8j+LcHuiKR4yvr07NJ9Rvc06GlKjfRJ1vZw+DpcXXzi5I+cg58NNWCuUq5ml
         /N16dAU5jgbcoFGbDBzkX60iRfSGZAD5G6r32P064dz09/SJcXgaIJlV3D+sqh9DIBMG
         qkyO+3op9Aj8HYiCeAGx5h9qFeQMM5lA6tstubQzWaI5FAOtInn3Uy7N+M80USX+9X3v
         322rPZ7zpOKLQHpkQXgMaTceOeok23xu/S8bhahlaj0c9k+ACoTut7ABwhp5Nxu60sbF
         02G8GR5z1Z85NoxWwdf2A2wr0PfoqgYEG9Q6F3wyfCOwQYQEQeK/WdbU8BT1spk7P8k7
         roKQ==
X-Gm-Message-State: APjAAAWKcq4z6oN7cZ53vCNfGXzeXK2yww+3oQ6NeP7h8/yTxh2jBOpy
        9PyatWVw2QfZeeueHRNvq5uKI+3ViWc2uzMwPsI=
X-Google-Smtp-Source: APXvYqwh/Z2UbVbzyDzAdkPy9xtx2lRcxal05Gt8kW2UH5wGV+f2t3juLWLJvnsQVtVKmhTgH3dsoTD542H9YKOZopg=
X-Received: by 2002:a5b:543:: with SMTP id r3mr53951012ybp.462.1556584308728;
 Mon, 29 Apr 2019 17:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjQdLrZXkpP30Pq_=Cckcb=mADrEwQUXmsG92r-gn2y5w@mail.gmail.com>
 <379106947f859bdf5db4c6f9c4ab8c44f7423c08.camel@kernel.org>
 <CAOQ4uxgewN=j3ju5MSowEvwhK1HqKG3n1hBRUQTi1W5asaO1dQ@mail.gmail.com>
 <930108f76b89c93b2f1847003d9e060f09ba1a17.camel@kernel.org>
 <CAOQ4uxgQsRaEOxz1aYzP1_1fzRpQbOm2-wuzG=ABAphPB=7Mxg@mail.gmail.com>
 <20190426140023.GB25827@fieldses.org> <CAOQ4uxhuxoEsoBbvenJ8eLGstPc4AH-msrxDC-tBFRhvDxRSNg@mail.gmail.com>
 <20190426145006.GD25827@fieldses.org> <e69d149c80187b84833fec369ad8a51247871f26.camel@kernel.org>
 <CAOQ4uxjt+MkufaJWoqWSYZbejWa1nJEe8YYRroEBSb1jHjzkwQ@mail.gmail.com>
 <8504a05f2b0462986b3a323aec83a5b97aae0a03.camel@kernel.org>
 <CAOQ4uxi6fQdp_RQKHp-i6Q-m-G1+384_DafF3QzYcUq4guLd6w@mail.gmail.com>
 <1d5265510116ece75d6eb7af6314e6709e551c6e.camel@hammerspace.com>
 <CAOQ4uxjUBRt99efZMY8EV6SAH+9eyf6t82uQuKWHQ56yjpjqMw@mail.gmail.com>
 <95bc6ace0f46a1b1a38de9b536ce74faaa460182.camel@hammerspace.com>
 <CAOQ4uxhQOLZ_Hyrnvu56iERPZ7CwfKti2U+OgyaXjM9acCN2LQ@mail.gmail.com>
 <b4ee6b6f5544114c3974790a784c3e784e617ccf.camel@hammerspace.com>
 <bc2f04c55ba9290fc48d5f2b909262171ca6a19f.camel@kernel.org> <BYAPR21MB1303596634461C7D46B0A773B6390@BYAPR21MB1303.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1303596634461C7D46B0A773B6390@BYAPR21MB1303.namprd21.prod.outlook.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 29 Apr 2019 20:31:37 -0400
Message-ID: <CAOQ4uxirAW91yUe1nQUPPmarmMSxr_pco8NqKWB4srwyvgnRRA@mail.gmail.com>
Subject: Re: Better interop for NFS/SMB file share mode/reservation
To:     Pavel Shilovskiy <pshilov@microsoft.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Volker.Lendecke@sernet.de" <Volker.Lendecke@sernet.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...
> > > No. I'm saying that whether you intended to or not, you _are_
> > > implementing a mandatory lock over NFS. No talk about O_SHARE flags a=
nd
> > > it being an opt-in process for local applications changes the fact th=
at
> > > non-local applications (i.e. the ones that count ) are being subjecte=
d
> > > to a mandatory lock with all the potential for denial of service that
> > > implies.
> > > So we need a mechanism beyond O_SHARE in order to ensure this system
> > > cannot be used on sensitive files that need to be accessible to all. =
It
> > > could be an export option, or a mount option, or it could be a more
> > > specific mechanism (e.g. the setgid with no execute mode bit as using
> > > in POSIX mandatory locks).
> > >
> >
> > That's a great point.
> >
> > I was focused on the local fs piece in order to support NFS/SMB serving=
,
> > but we also have to consider that people using nfs or cifs filesystems
> > would want to use this interface to have their clients set deny bits as
> > well.
> >
> > So, I think you're right that we can't really do this without involving
> > non-cooperating processes in some way.
>
> It's been 5+ years since I touched that code but I still like the idea of=
 having a separate mount option for mountpoints used by Samba and NFS serve=
rs and clients to avoid security attacks on the sensitive files. For some s=
ensitive files on such mountpoints a more selective mechanism may be used t=
o prevent deny flags to be set (like mentioned above). Or we may think abou=
t adding another flag e.g. O_DENYFORCE available to root only that tells th=
e kernel to not take into account deny flags already set on a file - might =
be useful for recovery tools.
>
> About O_DENYDELETE: I don't understand how we may reach a good interop st=
ory without a proper implementation of this flag. Windows apps may set it a=
nd Samba needs to respect it. If an NFS client removes such an opened file,=
 what will Samba tell the Windows client?
>

Samba will tell the Windows client:
"Sorry, my administrator has decided to trade off interop with nfs on
share modes,
with DENY_DELETE functionality, so I cannot grant you DENY_DELETE that you
requested."
Not sure if that is workable. Samba developers need to chime in.

Thanks,
Amir.
