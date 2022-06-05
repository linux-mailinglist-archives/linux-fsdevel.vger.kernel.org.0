Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE953D996
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 06:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbiFEEKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 00:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiFEEKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 00:10:11 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48B93E5D7
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jun 2022 21:10:09 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id w2so20299239ybi.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jun 2022 21:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3x72/ah7oVy1n7hZQ2TRq4JYjiu8oyFxE5Jon1kCtcA=;
        b=m2MotxmnxmWCcLS1bCzOQl4JZVWyZ58OqqFbmIEb2MqVGfuY17hEKe33k+cBV2kTmF
         hWNAxWuyuCL/R8Q2g06PdqUu26GZg5bpyJDSPirBXRCw8CFoiWk7DRX5TT1VMym/ZFNx
         TYUwRs/th2AAmguHDsRe2K1x6V/ZMv1N0P0Cm5combCRsCce4mjoMhfeAoFziQnZXDVh
         A1G9mdxEJmvd92/VghrdUlYslyXwqLycadENIAIdHWQ1lqHXvN7+JKDVbAmL/6RpddI+
         JWJeIz4Fdrb8yvASx0ms5Rukjru6Ul476f0qP3471VIPva5N/BZglAipifkRI7eaO8wP
         9vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=3x72/ah7oVy1n7hZQ2TRq4JYjiu8oyFxE5Jon1kCtcA=;
        b=CeFsstaxpbZNsptpXwXnKwrzDekCwjfdoMKQDDZvDAeWmEOCOyasQgsKZMC8PMpoC7
         RnMkaZIEjPpHm6/aSnFTw+dqYntTEwUyCkElocLDz4w8ZPj41dVM6rkgjXnGlfy0i8LC
         hvqY63zH+QtiXzM6ns+PW74un95TnlvEBIYmuymTj4FCufj7oH39kJUGqwFNLtrVY77S
         q5NhvRWNapNAOqQYnSAStLE/nys3zirN5CF26wqfVRrpWgrnOXrMw3yu8NroWsfiN3kU
         OyQOWZjpniQLTn2PmLvt8g+2+Jct0jXLU8ZP/c6MJ2x2HUwf7aToP+Xlf1tmtZAoZ78t
         LKhw==
X-Gm-Message-State: AOAM5307yeYVzVZVl1VrFfQXasS5ETt6vLONu0+5zD669zxRH3fcIsQR
        3H7jhUVm5iuLM2t/uJfMC2YgB5+tMXx+E1A+tQo=
X-Google-Smtp-Source: ABdhPJyLuRyUqVo3qdwlHYox5OP+26Yo7OSjr/7agA+lqVWiNNWcxczs5eIyKKGKzkDGwAvnuMLbFFGjNkiLzR3jpRA=
X-Received: by 2002:a25:d609:0:b0:65c:f2a1:6cf0 with SMTP id
 n9-20020a25d609000000b0065cf2a16cf0mr19059420ybg.417.1654402208855; Sat, 04
 Jun 2022 21:10:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:7906:b0:bd:b847:5058 with HTTP; Sat, 4 Jun 2022
 21:10:08 -0700 (PDT)
Reply-To: mrstheresaheidi8@gmail.com
From:   Ms Theresa Heidi <hovossourafiatou@gmail.com>
Date:   Sat, 4 Jun 2022 21:10:08 -0700
Message-ID: <CAJK1sRR_+Qs6M9rpHEXnVUeYBSMqjZ541mBfJE-M+cuuLAj3+w@mail.gmail.com>
Subject: =?UTF-8?B?5oCl5LqL5rGC5Yqp77yB?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b41 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrstheresaheidi8[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hovossourafiatou[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

5oWI5ZaE5o2Q5qy+77yBDQoNCuivt+S7lOe7humYheivu++8jOaIkeefpemBk+i/meWwgeS/oeeh
ruWunuWPr+iDveS8mue7meS9oOS4gOS4quaDiuWWnOOAgiDmiJHlnKjpnIDopoHkvaDluK7liqnn
moTml7blgJnpgJrov4fnp4HkurrmkJzntKLpgYfliLDkuobkvaDnmoTnlLXlrZDpgq7ku7bogZTn
s7vjgIINCuaIkeaAgOedgOayiemHjeeahOaCsuS8pOWGmei/meWwgemCruS7tue7meS9oO+8jOaI
kemAieaLqemAmui/h+S6kuiBlOe9keS4juS9oOiBlOezu++8jOWboOS4uuWug+S7jeeEtuaYr+ac
gOW/q+eahOayn+mAmuWqkuS7i+OAgg0KDQrmiJHmmK82MuWygeeahOeJueiVvuiOjirmtbfokoLl
pKvkurrvvIznm67liY3lm6DogrrnmYzlnKjku6XoibLliJfnmoTkuIDlrrbnp4Hnq4vljLvpmaLk
vY/pmaLmsrvnlpfjgIINCjTlubTliY3vvIzmiJHnmoTkuIjlpKvljrvkuJblkI7vvIzmiJHnq4vl
jbPooqvor4rmlq3lh7rmgqPmnInogrrnmYzvvIzku5bmiorku5bmiYDmnInnmoTkuIDliIfpg73n
lZnnu5nkuobmiJHjgIIg5oiR5bim552A5oiR55qE56yU6K6w5pys55S16ISR5Zyo5LiA5a625Yy7
6Zmi6YeM77yM5oiR5LiA55u05Zyo5o6l5Y+X6IK66YOo55mM55eH55qE5rK755aX44CCDQoNCuaI
keS7juaIkeW3suaVheeahOS4iOWkq+mCo+mHjOe7p+aJv+S6huS4gOeslOi1hOmHke+8jOWPquac
iTI1MOS4h+e+juWFg++8iDI1MOS4h+e+juWFg++8ieOAgueOsOWcqOW+iOaYjuaYvu+8jOaIkeat
o+WcqOaOpei/keeUn+WRveeahOacgOWQjuWHoOWkqe+8jOaIkeiupOS4uuaIkeS4jeWGjemcgOim
gei/meeslOmSseS6huOAgg0K5oiR55qE5Yy755Sf6K6p5oiR5piO55m977yM55Sx5LqO6IK655mM
55qE6Zeu6aKY77yM5oiR5LiN5Lya5oyB57ut5LiA5bm044CCDQoNCui/meeslOmSsei/mOWcqOWb
veWklumTtuihjO+8jOeuoeeQhuWxguS7peecn+ato+eahOS4u+S6uueahOi6q+S7veWGmeS/oee7
meaIke+8jOimgeaxguaIkeWHuumdouaUtumSse+8jOaIluiAheetvuWPkeaOiOadg+S5pu+8jOiu
qeWIq+S6uuS7o+aIkeaUtumSse+8jOWboOS4uuaIkeeUn+eXheS4jeiDvei/h+adpeOAgg0K5aaC
5p6c5LiN6YeH5Y+W6KGM5Yqo77yM6ZO26KGM5Y+v6IO95Lya5Zug5Li65L+d5oyB6L+Z5LmI6ZW/
5pe26Ze06ICM6KKr5rKh5pS26LWE6YeR44CCDQoNCuaIkeWGs+WumuS4juaCqOiBlOezu++8jOWm
guaenOaCqOaEv+aEj+W5tuacieWFtOi2o+W4ruWKqeaIkeS7juWkluWbvemTtuihjOaPkOWPlui/
meeslOmSse+8jOeEtuWQjuWwhui1hOmHkeeUqOS6juaFiOWWhOS6i+S4mu+8jOW4ruWKqeW8seWK
v+e+pOS9k+OAgg0K5oiR6KaB5L2g5Zyo5oiR5Ye65LqL5LmL5YmN55yf6K+a5Zyw5aSE55CG6L+Z
5Lqb5L+h5omY5Z+66YeR44CCIOi/meS4jeaYr+S4gOeslOiiq+ebl+eahOmSse+8jOS5n+ayoeac
iea2ieWPiueahOWNsemZqeaYrzEwMCXnmoTpo47pmanlhY3otLnkuI7lhYXliIbnmoTms5Xlvovo
r4HmmI7jgIINCg0K5oiR6KaB5L2g5ou/NDUl55qE6ZKx57uZ5L2g5Liq5Lq65L2/55So77yM6ICM
NTUl55qE6ZKx5bCG55So5LqO5oWI5ZaE5bel5L2c44CCDQrmiJHlsIbmhJ/osKLmgqjlnKjov5nk
u7bkuovkuIrmnIDlpKfnmoTkv6Hku7vlkozkv53lr4bvvIzku6Xlrp7njrDmiJHnmoTlhoXlv4Pm
hL/mnJvvvIzlm6DkuLrmiJHkuI3mg7PopoHku7vkvZXkvJrljbHlj4rmiJHmnIDlkI7nmoTmhL/m
nJvnmoTkuJzopb/jgIINCuaIkeW+iOaKseatie+8jOWmguaenOaCqOaUtuWIsOi/meWwgeS/oeWc
qOaCqOeahOWeg+WcvumCruS7tu+8jOaYr+eUseS6juacgOi/keeahOi/nuaOpemUmeivr+WcqOi/
memHjOeahOWbveWutuOAgg0KDQrkvaDkurLniLHnmoTlprnlprnjgIINCueJueiVvuiOjirmtbfo
koLlpKvkuroNCg==
