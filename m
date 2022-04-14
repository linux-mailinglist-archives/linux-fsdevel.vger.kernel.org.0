Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3199F501835
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiDNQF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358632AbiDNPmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:42:02 -0400
Received: from sonic307-55.consmr.mail.gq1.yahoo.com (sonic307-55.consmr.mail.gq1.yahoo.com [98.137.64.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05465C6EC0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1649949882; bh=l7uEf+zHfGuXlKA/7aMuUENHXKPZm3r3B51bsgI8f2Q=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=h+ZC2BvN8pcuEOWtR9p6QOwASKIVW8HY7x+GeFfL0FCDoMREsJoK+zDw/7f0u+vZ4AbUTDubeQ0yPJfna4JdMNkDqmyAnIJBLqoLKT4bv5BBBa7lUjBQYtDH6lRxlatEsLHcUPoCGl76yimjCoz6cnp+w/hu4PsEEZKwV+e7EZ5HosQ5gJBebML5FqlnYq/u1t8aQTe2VoZQCFMPy7w8cWTzqhvxZovuoKD9qwDTkFxH0CP40fUSjbd/CDuFjkKrjVe4bVxup5MOayb3ygXgbBiWb1NY2ZFVsWH3eAJLpJFwuVNJX68/3ZvsME4QHWJSK5gq4i80Gnf335fTyOoITA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649949882; bh=c0PR5MdqQVMbrOS9QgNLeD581KVxI66+yo63nInVZPI=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=fv4lNBYS5pFRa2GLDlY0GtUPYkRBA738m2HwyXxbgv51t0GqjdERVrnXyu8xJEZkE/qP2gLP/R92EpOxF7Xm0CCqU2JHHa3Wk2VRmD1TB+ishh9xY2zHgssMFELAqjfBbLHshg4FGadUcNWN5+8hpbIzEgXwDTWLyF5N18ersnG9DeYBq+ZIIImGrSQ/0GIlhHUnf6oYX+7PkSwXDphOgxtUCIumcpHPq9tWPEr/n3iikz9GGKoeRXCuyUT4mC4iYHkaEPvWdtijVTxLCypbE3iEOUxjUZXs4vBPHfc4v4C+45SwpSEVlDjwUTQtlpkcEYRb53tYvy8B7m9oW1QPaQ==
X-YMail-OSG: ixi72QsVM1ludGt1a_NOmZsL3Tw7Yf6Hu6LmOJvnhrp_Pg.OBrJkFUPM.k_p9uu
 t2iM4LjQNAOcKrDdY019Q6RRB2xHaQcrOi8JoyXT1U7klhVvFGTyb8XfjOCLJRj2lNxJ8q2Jjvdh
 0RCoA4bNSaEglicQOBF6JijL1UyjdGqANkqNLMF8WTZHT8qAWKHUAdNOWprquOz2aip0gHtlfW.F
 0xWCdWi1JNQHgebpbqM2ehQx37fndADEArENjDbErQINW3gwXdV6.BHRZEncyo_O7lFejfXw8nAu
 8wZAWTa1WhwWGVdqzti_7lgINmDzf6PAvnC9sVTYakQdynskwkUSBRx28YrAfEvIbC2qH3rntOmP
 cMa4KJ7f59etRXona43oI.tNprJz9MEd3HMvGgdsO1hRpIwM9ixzjhTUPLbMOSDD0YmFFy5AdaS8
 rxom2dwujAZ7WldrKaLTDypL.tCaBPvoJx3YmdC6I8yK54rKwVc3Xvv.fjGKmR.TqtD4Tpf3mRh4
 gU2T7phP0k_mNV3SfwBY5uyKiBVoTYH4tqARM9.T.0HaRuzw3ZrNbvvIiMGmmB0F5WuYcl4pygSJ
 ccprenv8z5lX7mrLTvVDsUh43Q8aSLrll0t6jqbGf2yip8416VNNKHS2BARuun1b_z4sWmSo8_HS
 ikDysAr6t5LyyrUiyqsCW5OoXI0d3pBTmuMlFdpWrOOAGBRBLOalciBwHxkbW_YlPZtUTCmsCLNW
 eRRV5vs9bQYD.H4Wstf5ghG17lJkvCG2X0QgtqfLA737NdbzeIRVD8iFOxlmh_Y_zCZJ_2E4v0B.
 xXgHnnCbGAxFuiFGr7WnSQCf1ne_hJf6bTaQKrNI3tPbJmjuX6QfhVZyqqeblBvD0asA5iIqP5ft
 4JuOcawECMqsLJUgBLWWOBw5YLGGQfAlsdfHWgLmbzvl8gy3rienmPLDZtQa.uFNVb8XpLLEh93J
 AC3RCdzF9zOHQbZw39ZDQVeavhTMT1q_2UKxZZbmwGH6GNuNlrYwiQcaeOfSHRWDabId2ml4mUQR
 RFFON__K84I9DPQQx5IyI3YvR46LhJwagtwWYJF_bBUE86W6kf3_f4epIb_wRXj.HIJ29k94FvF_
 AgloODt10QIMUepFAQjRX8pJcRJBPNVc0I5HgV0bfiFpTNP3DQfM9HhJfoQWUYpfEgtZrnEZ0bYc
 rXLV0aHPyjqTuJXwxwbBXiuk2uK7K5WbEJxvQ25fmdx0ODo1MCjBLCzMi.Jz9gK7w3toR9_YoELv
 .jEWGSU78GfBVC8Bl1lII2VporKr09cqrtCuoho8WYVPiWZJEzowjBlETfBgriWEmd9Sy7pI9KEo
 LyJwYL5dAz5n.JEukZ7FfzBCyf0yohXpY4mw1xighpeSnmeLHeqKQD6Noc.90esAHwxfaWdVzcqw
 vdv6hCcKB.kYiA6wJvlXwAp2lSfpT4nSR70AdGnHlsVm1GRVdkX2D5Mpr6c3L9wBoa5_oesEpVo6
 rXgpj7YZ.ptcghQwRXqa2ce4GrWpSFodvnyloFkoB2gWux.LQjoElUboRwNNWNbwYeQmP75CCr99
 H3ix8fgwAZSoMFoSQJN0vbuWawRblVDxqfZ57_CnNuQWAcWCKnmcYcVVWh7rJpJoM.ZRakDakI3a
 7H49tOCA1OUP3GlfxuR28ypdhF5X.x0BCZ4gOUmlePbXGspmb.FoV3hR_3vskdEXg0s1zfF2fP1m
 DQMb69kxOKu7MEtGDxMBuI3QJG.hSUJmwKEDhDQ8xy4C3v8yeuHXmt3i1dAva01wCdeaoI4o2HNp
 xraygLZ5eiIfcCiOUjhR6xRbroLClVMtgJuSR_r0abBVIHBBfEVVxDmBWwBxcbx2n0J_eE8haMCL
 hesR30KTb0GsDF8IZjlQeUWdyMoGZMQ9K5IfXX3_VO_4qA7TnpUayZAQcmEGZw4QDuCDhtPXTbg_
 Lrq6imWqIqkLOa77ZyccZl_tVndLc3_bVv_Xb.4KcKkmNDl9CuC5aRL0wJ0jBXtf76Wr56I34xaY
 HoK07z0oV1FVukmEeiqjLtH0Bi9SsF_7BV3B3gK5S3yy2fO2bfRdWdbVOLPL3HWQpSi7nWcv0Wq5
 yHGlTGNSX5U2AipMpz90gBCIa3mM4TBeNgwChvHra0TO_5rxjsSPZOZKc.iKcizrrnETSFXAqGFd
 6e.B5t0ohwE8SO_600iyK5F0AD5RB30OaOuiZFrIoTwDN4o.OY0txDMPjHbSAIjVx7WLNXf45i2K
 Dpo7wcPaJ5i3RFM7d4zoP3FsWFJKTf7MD9qKCNM86HojINd3evbgu7ZSfJrsRsva82arIk2UmcVD
 p
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Thu, 14 Apr 2022 15:24:42 +0000
Received: by hermes--canary-production-gq1-cc54c7bb9-9gfh6 (VZM Hermes SMTP Server) with ESMTPA ID 70fcc1be1711c5a35768f5595215e0c4;
          Thu, 14 Apr 2022 15:24:38 +0000 (UTC)
Date:   Thu, 14 Apr 2022 11:24:35 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] mm/smaps_rollup: return empty file for kthreads instead
 of ESRCH
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220413211357.26938-1-alex_y_xu.ref@yahoo.ca>
        <20220413211357.26938-1-alex_y_xu@yahoo.ca>
        <20220413142748.a5796e31e567a6205c850ae7@linux-foundation.org>
        <1649886492.rqei1nn3vm.none@localhost>
        <20220413160613.385269bf45a9ebb2f7223ca8@linux-foundation.org>
        <YleToQbgeRalHTwO@casper.infradead.org>
        <YlfFaPhNFWNP+1Z7@localhost.localdomain>
In-Reply-To: <YlfFaPhNFWNP+1Z7@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <1649949601.z8rr7ed5qb.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20001 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Alexey Dobriyan's message of April 14, 2022 2:55 am:
> Returning ESRCH is better so that programs don't waste time reading and
> closing empty files and instantiating useless inodes.

Yes, except ESRCH is not returned for open, it is returned for read.

> Of course it is different if this patch was sent as response to a regress=
ion.

I'm not sure I would classify it as a regression; I don't have an=20
existing program which broke, it is a new program which happens to use=20
some functionality which worked with a previous kernel. It is=20
theoretically possible that some program exists that currently uses=20
4.14, and will break if upgraded to 4.19+, but it is also possible that=20
some program exists that currently uses 4.19+ and will break if this=20
patch is applied.

Cheers,
Alex.
