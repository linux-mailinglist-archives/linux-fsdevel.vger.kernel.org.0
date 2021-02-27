Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF758326D6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhB0OnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 09:43:05 -0500
Received: from sonic317-20.consmr.mail.gq1.yahoo.com ([98.137.66.146]:44185
        "EHLO sonic317-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230012AbhB0OnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 09:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1614436905; bh=Khr8xeYr3rR7hPPcjadWTCVXTglOgFLWFa+JyPCxjwo=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=E0cTLs7rMu5GrR/M7Hpi10cHd+zQtWX+GNlaLiJtYDzmaSK4Z4lcP6odRPAF0jQj6h9MM7qm6sBA/Yny7OlW8i8l9Jp6uD4pt59B+6uzW5+ZP+2n9WMfjXPr7JlGwCSxVmcEtVGcn66AKLVMCAY6QCff16cYBwd2RUMuf2xLxcRIqPsN2I0bh8D6iizjmgKCgcty3k5wbISfpBjIGJMW2FMoSOvl0cVVOc8un0MkGnb0bErBe6qdpq9/fXHpVjwPY5Pc4i1emcUQp4aVxjgRi3Tgui0PXPhyTwIOIDRjCIU6K2Co+I6QE4LrN0ySU8OPmPdg59ogpEJbDjavzi1Fhw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614436905; bh=6hAk0KGeO3qy1WxjgCdx9sj14DnsxDZClpO2OHikoAY=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=Whwy6aeT3jXRNtkj0EAiwmyl48lOkcAToQzF9C4NaZurKr88dHZJyF2DnREmxg9sTg6o/brOqSzrJ3eRw7XATNS9Uv5+mNRr9+rR7T2QpgZ8Hf5vBdVSYnZvJxyLXMUlhgM9ZMx8Oy/nnpPRB1viG8eRG2MjBOh7xIqByzO5hG72Xd9+Iow3Ubuagwo3jjw8CzMhRcxzHOJqg4mjpSTB9s8Pplr1Sp1ebQiQdsLsHzKe9IPGTeMswZAP9qUP0MHgX5C29+JXp4sBKlqxVn8Q1xFJzRLnhqiIboxU4Vd1aQW2DVWZT73oMlckioQj4m0Hc82g0+2hRZGN6WYz1/IUAQ==
X-YMail-OSG: jNApkUMVM1nInzTWz19MWH6fag4j0c95rlxUiVzmEcxaQzmXHVQmEpabqZgNGo_
 l6p_jMMGECzqTx8X3xcFwXJ3PMj5SLyIahcW7oAOUMtqF5RGMUDOaGToPZVFywsyqgO4HR8EeuJ.
 cdfs7uaRE_yz7p77ytaRQbe5BZLC9yoGRERMTzcunB2Rk._OVB99.eFfi1Os1HJO5hYFZrJg9o9B
 716IHlJFFeA5.cSi5P_Cu3Ix8xhI9OFpKHMLD3RvHq3gMtfkp6eJzLy1biHAW69yUiMQ0C.JICbE
 bV9iDD2i.0DN8PWQr2vT5pqIGRkQ3xrG.8FpFYzC7EDzAQO4lb6Rg5F7Ag3tmDczA3TUDussTWKj
 UbZZ6TfPD8nVrh2S060TfgX7h8lDc9OWLET.6BBtPtttxRDr5p4armA6EB9Eyimh.VDR5ittKLrs
 BcSmz2IkcRmpPbEVZhj5vried9rtQ7qp_qju04O7bW_Iol1ngZd3IIHRRtN7_61ghyXZtlw5fh6H
 dHFmdwKJGuK.RhKK7fQQxs2dsHhr9p5ob2T4fa2w_GWkFnUXxasRbPgzJmg8JVKIDIk1JRRfiriA
 gv6nOd7USkzO65q5QjHYCyFaSbKLhL.exkWkcnvnJiEvwLA_2QpkbHjbo4F4WzooGpp0MHdZZ9rh
 xgOZERvdRI7w6SZQJuFZzTspibmGa6OhmCsjAJ9EObjLBddQZ0KRgPBIm8i7EK8LD8xLd6Q3dikG
 66jXHguSX8DAA6RUEgIqsg8C64LjhN9mc9S6y2BOUdOJDauaNErASSfDTIeF1rPPsOVO2qhvO52f
 5_uT0A6djwJ08_Us1WSzITEQq4twqJFf8SsVzAXz28zMiNiSThZzaTHL51cSE0J_neEHvllyFig7
 i3LWwUeIGyUNhDe7sMpHxyRbPPfinPXaR3mJpCgZsT.KCSdibgI0X7C1dfSXiKF4KdstZ9NMixzC
 JCOAGy6_laYZoF5nybJW_hQZW190mVRqUbO6g5qM2Lx9qjb.Gne4O_p8hkO7jmVG9Wdz61vnaz3a
 wvTs5iv9ukj9QgcTVRlRNaNNGoL5VnPhAREPOM5sT.ZbmsgQ_sO2umn_cgE0CYjhozPx7aPh3l_t
 gthsl8Z3.Dr.ZpPaJSp0m3OlSXEiERAaRs9NT6u5rMIqOB.XFlOcBEs8NnqQVrQdIWzAVmE56yS8
 fqU0eTz8Q46HtiF7Mtt9NJ465q6EhWr6XI4BjljQjrJtQPe4i3ybXFKP4XUT4ZP5_Dz3ks2RUW3k
 v7GqsNVZ6qfPQOFktCqt.R_cp1POiYFf.MrjBBDPtbQtu7ee5w_TYxgPtxBj2ctW1VgB12LF5Fvy
 tXqTslbWOuCEGoLf5YcMfc6KymugfcLTVXpn0htY74JmyN3g8RZ9LWxKrODkQpCPsIAUKhIZyQDq
 S2genXByNjKfk0oNeXpioD0vr5ei.cd1RTz8O0qHjKuIJhkaj2pB9h55BfVDILNZ5bqAOLcfeMwe
 EwPSl70LsauRp1pGbt5CqpRb7GDUz1KjDMSYHaLeps3_CJGSo7gZwh_zkMC.axcGHHJRtjlGflmt
 DKWlnJZQr3.8Ldgo4I7Y7Shua2BXl8OibwYinEW4opUE5GeHM8Uih3U22ErsTGE2GSSxJsCrdgcY
 fCJ5phhxOuF7a.wIeWNAd5I8mcrN1N.7BmaeMWeXF2LHk8z.M.DO0eYhUOlL22paqXxIpAUPUF2q
 IWUBAu2d.iK.oKxVJ0i_IYQczZYfMX7oJF5_Hd_AgQ5MixHKjk6WJsbIe_cBxXoN4F9kIYoY2s00
 3EX8lnRmPN3voo0sCbI._ezCxGpiLcOfj.J0zacE4hIGo5VupjoJQfHPwDC4G6D45EvQu7Qqe5UF
 6X2pA_HfhtXKJJQtLHBJuouaOa75tMOYyhA6j9zkXr4joJMir01bpXACT2j8aXggbSBUUwsfgLfT
 9i9gxg2hXOBHgQEOh6bS.UbzyZor9fUZ4yIVOSlKjnrmPh6TG_rSFpJVmP8QrsAa0iuzvClFop7t
 tJN5o8Bp_5M46Z_OwzmzxI7w2l15fgWr4_KOlzPZLUB8Knnfp_z6qKkky2rGynF2taRTfwtzTSX8
 U7HycptyAfiiDbZ6u_0aWTK2CVLIls9gh_98A1E7naF3h_xYN2iNNj1UTNP_GvmCTjezOkBSkYmU
 XNdm8vGo1HAdK7yCXUvp1QiOsUZWzCmy6Q2taP90eCNkiC1xv6AKDnntjIP24oPz9YIIF27oNyL7
 EKwnEgKHwB9mbUc6O_GIBElYiQgLIHNPSd_tS9QN7xOBDHI.751hXSve8u0hFEG0Ab5pzy92BHhn
 8E0pGYb9dxZu0ezZLOleNWfOF7te8yn8exCQo4OdqVk9XrNkwGtzMhBqbhSQ.qpCm6e_h2YMOXvP
 UcEwW31sXutq8Ygx2eDA77KOilriJU1VLhvIHMmgRSOGjVtP5x.FmxE1IKJoashUdz7NEjUOIumu
 e5TnUJZwwXTnja8szkIN47W6I_e3HkP.9lPB.7A3n16Lx6Jr8pm4sifUm0bD2TurdrsBlqjZlEFA
 dYb35wSUhY61DjRX.CjxHyRJ2_TufNJofgxfY9V0KRRvpaP9tCcbcjns2nOEeij3R8zHWCb3ZMhG
 n3IFG_P5W9mtBPYLCN.GR_c6BuEOfUH4VoNbE45yUr1RL5WB_TPa5pV.2JvHTVtMftHwvn18uXya
 BkmqsL8JNENfMZ4tVq51mWXPsR7UzsoZPOYCHQggtoB3BAjLbCopAUfohnYvVqnsxWsGj.XMAhhZ
 1aldfpN6ffgsct4KVv6f2lggWfIvBgCa.yMdWoBHAV_4Yaiho6UlF19ZmCZdL5HJmkSyJfgYU8V_
 3DGUWiihB.mEjvXPydMdGhPzilrMYpJtlejzsxMSXJocUbA0QPfPVSD6YouygESYYw3iqltdQOS7
 c2W.YNa9SvnMxby2.AnApuezh0GlxM0cOvgicKGlVLuS74q1ruEpnPYrnomQ6UHhAdrhSPZvsL2q
 fXYR3MPmhL53gcgKI6rzOBxASHmTE9ff5i4is7FWNoe_Vydmw4cuSM3c-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sat, 27 Feb 2021 14:41:45 +0000
Received: by smtp417.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fb5b4ee0de1ba0070e298b9ac6030c47;
          Sat, 27 Feb 2021 14:41:39 +0000 (UTC)
Date:   Sat, 27 Feb 2021 09:41:36 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] proc_sysctl: clamp sizes using table->maxlen
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrey Ignatov <rdna@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Iurii Zaikin <yzaikin@google.com>
References: <20210215145305.283064-1-alex_y_xu.ref@yahoo.ca>
        <20210215145305.283064-1-alex_y_xu@yahoo.ca> <20210216084728.GA23731@lst.de>
In-Reply-To: <20210216084728.GA23731@lst.de>
MIME-Version: 1.0
Message-Id: <1614436629.aqa2hys64t.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.17828 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Christoph Hellwig's message of February 16, 2021 3:47 am:
> How do these maxlen =3D 0 entries even survive the sysctl_check_table
> check?

maxlen!=3D0 is only checked for "default" handlers, e.g. proc_dostring,=20
proc_dointvec. it is not checked for non-default handlers, because some=20
of them use fixed lengths.

my patch is not correct though because some drivers neither set proper=20
maxlen nor use memcpy themselves; instead, they construct a ctl_table on=20
the stack and call proc_*.

> Please split this into one patch each each subsystem that sets maxlen
> to 0 and the actual change to proc_sysctl.c.

I will do this with a new patch version once I figure out a way to=20
comprehensively fix all the drivers setting bogus values for maxlen=20
(sometimes maxlen=3D0 is valid if only blank writes are permitted, and=20
some drivers set random values which have no relation to the actual read=20
size).

Thank you for the review.
