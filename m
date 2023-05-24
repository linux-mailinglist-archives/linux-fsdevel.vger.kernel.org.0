Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF870EC89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 06:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjEXE10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 00:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEXE1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 00:27:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F73DE6;
        Tue, 23 May 2023 21:27:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4effb818c37so333792e87.3;
        Tue, 23 May 2023 21:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684902442; x=1687494442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m7Lg8DDm/ij6uVAAnSJrfz7gWG7Octz6xQjt6V3Uyyo=;
        b=FC9jPngS2I4ZuBz3yXaWmAaDbiTwoGylw/lIWmLh8lFe2LP5W5Y29ueBAXLF05cQyg
         3JQg9qXLbAG8k51OLXvx4buQM3kUkoeUJt6Nl5pam0sZH/22OrdQrCszcipBd7JgvQVM
         HHJsNmQ16IH+G4AE6jUKwrNE0Tcf3NUZKvy23petgWPOwtk1xyloqXgnRcoOtXZDVFiL
         9WyxNw3RlNZW2O2X6/YHCEycpzA6pBdpwUY1TzSwRzUQfYZH9rCsi6XOeraMra/ePGLX
         HFmWZXtr5BtQjeSIcFgmlVjaHPwPIuB6+Yf1qjRPWM3F/CYI9MjvTTWt6i50Ns4u2N7q
         MhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684902442; x=1687494442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7Lg8DDm/ij6uVAAnSJrfz7gWG7Octz6xQjt6V3Uyyo=;
        b=KRlpG578e3KPlImw9bnUF2rpMOgqzT4l68TpbxhvBNOoe25qSX4ywoDqD9w9vL5f/c
         LvWo84efIZEzv8b5wns/kb7RznhJRtmkoshcl/bsP682vuqbm+V4jWTiZz0aL/Z0emfg
         eCtSOgl/3bRKWjYXv2wySmRkFW8zBoBxvj13NneIYk9gWKr0KgItF2Re9dkh/WYB9Ao6
         8ltzxjsYiphjprcg4He9Z2aI8RIfy+tOvJ1xB3+FB/hRdIPT8wf17D8o/8ubn65uhltO
         TJWh9yn6wX+H8vBrT0cOZ025bYnjzZsZ/8H0w2lm2pxe5pFDzc+Dms5xNoJpQTZhJRjI
         bNGA==
X-Gm-Message-State: AC+VfDwmPjTvqhF16pFgRYZj9Tam5taDnO8yrmsm+W7bhp1mJuIFWq0U
        nW9nJeLf4p/oeACtksLReGIYYB0vb21BmHmohUFNinCGE4Y6pQ==
X-Google-Smtp-Source: ACHHUZ6w3alXwd2NcYMYKlrzcGuK/36n7eZz2lAz1OSxnXDUW6hJh+PySMGGi1b2HG06gWgpZb5PtjjFNb4ELqBSsLY=
X-Received: by 2002:a05:6512:219:b0:4f3:b32d:f744 with SMTP id
 a25-20020a056512021900b004f3b32df744mr4465194lfo.11.1684902441576; Tue, 23
 May 2023 21:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msVBGuRbv2tEuZWLR6_pSNNaoeihx=CjvgZ7NxwCNqZvA@mail.gmail.com>
 <CAHk-=wjuNDG-nu6eAv1vwPuZp=6FtRpK_izmH7aBkc4Cic-uGQ@mail.gmail.com>
 <CAH2r5msZ_8q1b4FHKGZVm_gbiMWuYyaF=_Mz1-gsfJPS0ryRsg@mail.gmail.com>
 <CAHk-=wjYTAK4PSK23bDm_urZ49Q=5m=ScYcmK27ZJNKSBPdbgA@mail.gmail.com> <CAH2r5mssPFZO3XZvws+=C+Gywjs_79bpC0nByeWP5F2T7DWHvw@mail.gmail.com>
In-Reply-To: <CAH2r5mssPFZO3XZvws+=C+Gywjs_79bpC0nByeWP5F2T7DWHvw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 23 May 2023 23:27:10 -0500
Message-ID: <CAH2r5muhWo9mV44n8AUQgKX+gpBZ=7sWpn7ns7+EODXDXzofLQ@mail.gmail.com>
Subject: Re: patches to move ksmbd and cifs under new subdirectory
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008306ee05fc68eb2e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000008306ee05fc68eb2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One more minor change (fs/smb/common/Makefile was missing a two line change=
).
Running automated tests now.

Attached updated patch

On Tue, May 23, 2023 at 9:41=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> Lightly updated (e.g. to include a missing trivial change needed to
> Documentation/filesystems/index.rst that Namjae noticed).  See
> attached.
>
> Presumably can defer the additional cleanup/prettying (ie those beyond
> those required for the directory rename) with distinct patches later.
>
> On Tue, May 23, 2023 at 12:35=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, May 22, 2023 at 11:39=E2=80=AFPM Steve French <smfrench@gmail.c=
om> wrote:
> > >
> > > My reason for adding CONFIG_SMB_CLIENT, enabling CONFIG_SMB_CLIENT
> > > when CONFIG_CIFS was enabled, I was trying to make the Makefile more =
clear
> > > (without changing any behavior):
> >
> > That sounds ok, but I think it should be done separately from the
> > move. Keep the move as a pure move/rename, not "new things".
> >
> > Also, when you actually do this cleanup, I think you really should just=
 do
> >
> >   config SMB
> >         tristate
> >
> >   config SMB_CLIENT
> >         tristate
> >
> > to declare them, but *not* have that
> >
> >         default y if CIFS=3Dy || SMB_SERVER=3Dy
> >         default m if CIFS=3Dm || SMB_SERVER=3Dm
> >
> > kind of noise anywhere. Not for SMBFS, not for SMB_CLIENT.
> >
> > Just do
> >
> >         select SMBFS
> >         select SMB_CLIENT
> >
> > in the current CIFS Kconfig entry. And then SMB_SERVER can likewise do
> >
> >         select SMBFS
> >
> > and I think it will all automatically do what those much more complex
> > "default" expressions currently do.
> >
> > But again - I think this kind of "clean things up" should be entirely
> > separate from the pure code movement. Don't do new functionality when
> > moving things, just do the minimal required infrastructure changes to
> > make things work with the movement.
> >
> >               Linus
>
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

--0000000000008306ee05fc68eb2e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-move-Documentation-filesystems-cifs-to-Document.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-move-Documentation-filesystems-cifs-to-Document.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_li17ecct0>
X-Attachment-Id: f_li17ecct0

RnJvbSA0ZjBkMDAzMWNiOTcyMDFmZGFmNGNjYzM2MTkzMTBlMjAwZmFlN2FjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IE1vbiwgMjIgTWF5IDIwMjMgMDk6NTA6MzMgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBtb3ZlIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvY2lmcyB0bwogRG9jdW1lbnRhdGlv
bi9maWxlc3lzdGVtcy9zbWIKCkRvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvY2lmcyBjb250YWlu
cyBib3RoIHNlcnZlciBhbmQgY2xpZW50IGluZm9ybWF0aW9uCnNvIGl0cyBwYXRobmFtZSBpcyBt
aXNsZWFkaW5nLiAgSW4gYWRkaXRpb24sIHRoZSBkaXJlY3RvcnkgZnMvc21iCm5vdyBjb250YWlu
cyBib3RoIHNlcnZlciBhbmQgY2xpZW50LCBzbyBtb3ZlIERvY3VtZW50YXRpb24vZmlsZXN5c3Rl
bXMvY2lmcwp0byBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3NtYgoKU3VnZ2VzdGVkLWJ5OiBO
YW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpBY2tlZC1ieTogTmFtamFlIEplb24g
PGxpbmtpbmplb25Aa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZy
ZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvaW5kZXgu
cnN0ICAgICAgICAgICAgICAgICAgfCAyICstCiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3tj
aWZzID0+IHNtYn0vY2lmc3Jvb3QucnN0IHwgMAogRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy97
Y2lmcyA9PiBzbWJ9L2luZGV4LnJzdCAgICB8IDAKIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMv
e2NpZnMgPT4gc21ifS9rc21iZC5yc3QgICAgfCAwCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQogNSBmaWxlcyBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCiByZW5hbWUgRG9jdW1lbnRhdGlvbi9maWxlc3lz
dGVtcy97Y2lmcyA9PiBzbWJ9L2NpZnNyb290LnJzdCAoMTAwJSkKIHJlbmFtZSBEb2N1bWVudGF0
aW9uL2ZpbGVzeXN0ZW1zL3tjaWZzID0+IHNtYn0vaW5kZXgucnN0ICgxMDAlKQogcmVuYW1lIERv
Y3VtZW50YXRpb24vZmlsZXN5c3RlbXMve2NpZnMgPT4gc21ifS9rc21iZC5yc3QgKDEwMCUpCgpk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9pbmRleC5yc3QgYi9Eb2N1bWVu
dGF0aW9uL2ZpbGVzeXN0ZW1zL2luZGV4LnJzdAppbmRleCBmYmIyYjVhZGE5NWIuLmViMjUyZmM5
NzJhYSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9pbmRleC5yc3QKKysr
IGIvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9pbmRleC5yc3QKQEAgLTcyLDcgKzcyLDYgQEAg
RG9jdW1lbnRhdGlvbiBmb3IgZmlsZXN5c3RlbSBpbXBsZW1lbnRhdGlvbnMuCiAgICBiZWZzCiAg
ICBiZnMKICAgIGJ0cmZzCi0gICBjaWZzL2luZGV4CiAgICBjZXBoCiAgICBjb2RhCiAgICBjb25m
aWdmcwpAQCAtMTExLDYgKzExMCw3IEBAIERvY3VtZW50YXRpb24gZm9yIGZpbGVzeXN0ZW0gaW1w
bGVtZW50YXRpb25zLgogICAgcmFtZnMtcm9vdGZzLWluaXRyYW1mcwogICAgcmVsYXkKICAgIHJv
bWZzCisgICBzbWIvaW5kZXgKICAgIHNwdWZzL2luZGV4CiAgICBzcXVhc2hmcwogICAgc3lzZnMK
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvY2lmcy9jaWZzcm9vdC5yc3Qg
Yi9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3NtYi9jaWZzcm9vdC5yc3QKc2ltaWxhcml0eSBp
bmRleCAxMDAlCnJlbmFtZSBmcm9tIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvY2lmcy9jaWZz
cm9vdC5yc3QKcmVuYW1lIHRvIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvc21iL2NpZnNyb290
LnJzdApkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9jaWZzL2luZGV4LnJz
dCBiL0RvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvc21iL2luZGV4LnJzdApzaW1pbGFyaXR5IGlu
ZGV4IDEwMCUKcmVuYW1lIGZyb20gRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9jaWZzL2luZGV4
LnJzdApyZW5hbWUgdG8gRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9zbWIvaW5kZXgucnN0CmRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2NpZnMva3NtYmQucnN0IGIvRG9j
dW1lbnRhdGlvbi9maWxlc3lzdGVtcy9zbWIva3NtYmQucnN0CnNpbWlsYXJpdHkgaW5kZXggMTAw
JQpyZW5hbWUgZnJvbSBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2NpZnMva3NtYmQucnN0CnJl
bmFtZSB0byBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3NtYi9rc21iZC5yc3QKZGlmZiAtLWdp
dCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKaW5kZXggOTAyZjc2M2U4NDVkLi42MTUyYTQy
NTFjZTcgMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0xMTMw
MCw3ICsxMTMwMCw3IEBAIFI6CVRvbSBUYWxwZXkgPHRvbUB0YWxwZXkuY29tPgogTDoJbGludXgt
Y2lmc0B2Z2VyLmtlcm5lbC5vcmcKIFM6CU1haW50YWluZWQKIFQ6CWdpdCBnaXQ6Ly9naXQuc2Ft
YmEub3JnL2tzbWJkLmdpdAotRjoJRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9jaWZzL2tzbWJk
LnJzdAorRjoJRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9zbWIva3NtYmQucnN0CiBGOglmcy9z
bWIvY29tbW9uLwogRjoJZnMvc21iL3NlcnZlci8KIAotLSAKMi4zNC4xCgo=
--0000000000008306ee05fc68eb2e--
