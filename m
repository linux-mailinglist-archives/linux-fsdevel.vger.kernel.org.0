Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2A41F723
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 23:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355654AbhJAV4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 17:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhJAV4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:56:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6779C061775
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Oct 2021 14:54:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x4so7148012pln.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Oct 2021 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Y2F9tIAyLMuMdvZ+xZbB5A4lCV2UGNUjjsvsd+NvfA8=;
        b=WreVklBggxei96NbU8ryj3miFwVUGz33146Bjjpotu/SgaGDVHfMAxd66UfUwDGeK2
         s6ztopBoSJDInYcU7oXlxkZz1BcBoxmPBBI1xPO/uMs79M0MRKCX5sFKdGExo9ssjWpK
         aE6MRoCvHIwz9DG8dka2mJRnqAp924032T3GXpgYmHp1CPj6C+K6WIQzTfBJBnKweNmM
         ZLVFWfxC0mwGtw/UcxJJEDh0joqnJ+0ktuCjCzKpjizgcKssBE/CDRid6aYllv7PeywG
         xO0osNLhBVxCzmiJ9NI6dqYf1f2X1hN0ikVutmLEFwaZLmsm5kFgNsOhgEjwEAXdxrvx
         KwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Y2F9tIAyLMuMdvZ+xZbB5A4lCV2UGNUjjsvsd+NvfA8=;
        b=l/RoO7cVO91SZLhvRSXqgYj1aJ46KyZih0UTRuzK7pmyLQeRGDt/v5tJsebcIebE+k
         LOa386CiXhubuDOXL9QzbSrqMrdYOUgDlupOctDmX9LS63utUPRcDaJPcmpqeo7vwXGc
         jSjpRn0lWvmqqkOVNmuESGznlMZeujPqgsTdgGNp+2U3hvRaW2yvZ5a0L361Y/Pp3EIu
         wVFSLqoXgpTVK+BDQoxKFtHg8xWwKBl8lbHSnlJ0vc5d+Ridc4gcdilvsLOOs3yl2DfV
         quRzpnOioY89OxlVIr0IBOF96j+ifU1r+xAZ+QkPAnQPJ39ETfRdJ1m/5EVye0UeZ86H
         7g4w==
X-Gm-Message-State: AOAM530yiJfJomuHMFqcSFVsXULGp7XM6LJxDXhwS/Z6eVtNPtNad8tG
        mwRyzePCyUdw7XEjn/9S1zs+F/bgGLZCFWCYi4w=
X-Google-Smtp-Source: ABdhPJy7yOHZBox9/6AbjfqaThtyOQ9uxtmnaGDA9onO8iCyLkeznb0D80Fd8fLfFfJbcoq9QlAEVLVXicBeicZvrLo=
X-Received: by 2002:a17:902:d2c6:b0:13e:9bc9:1ae3 with SMTP id
 n6-20020a170902d2c600b0013e9bc91ae3mr11077plc.87.1633125267243; Fri, 01 Oct
 2021 14:54:27 -0700 (PDT)
MIME-Version: 1.0
Sender: manuellawarlordibrahim7@gmail.com
Received: by 2002:a05:6a10:1d8f:0:0:0:0 with HTTP; Fri, 1 Oct 2021 14:54:26
 -0700 (PDT)
From:   manuella warlord ibrahim <manuellawarlordibrahim@gmail.com>
Date:   Fri, 1 Oct 2021 14:54:26 -0700
X-Google-Sender-Auth: Bnsb_7B77iLKsgevwNMHaB_tfrY
Message-ID: <CA+ZVOZjFXqv694uoVdda_6jNtYOz1W2w1ZHX0SHcxDKtPJbTyg@mail.gmail.com>
Subject: =?UTF-8?Q?aspetter=C3=B2_di_leggerti=21=21=21?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Carissimo,

So che questa e-mail ti sorprender=C3=A0 poich=C3=A9 non ci siamo conosciut=
i o
incontrati prima di considerare il fatto che ho trovato il tuo
contatto e-mail tramite Internet alla ricerca di una persona di
fiducia che possa aiutarmi.

Sono la signorina Manuella Warlord Ibrahim Coulibaly, una donna di 24
anni della Repubblica della Costa d'Avorio, Africa occidentale, figlia
del defunto capo Sgt. Warlord Ibrahim Coulibaly (alias Generale IB).
Il mio defunto padre era un noto capo della milizia della Costa
d'Avorio. =C3=88 morto gioved=C3=AC 28 aprile 2011 a seguito di uno scontro=
 con
le forze repubblicane della Costa d'Avorio (FRCI). Sono costretto a
contattarvi a causa dei maltrattamenti che sto ricevendo dalla mia
matrigna.

Aveva in programma di portarmi via tutti i tesori e le propriet=C3=A0 del
mio defunto padre dopo la morte inaspettata del mio amato padre. Nel
frattempo volevo viaggiare in Europa, ma lei nasconde il mio
passaporto internazionale e altri documenti preziosi. Per fortuna non
ha scoperto dove tenevo il fascicolo di mio padre che conteneva
documenti importanti. Ora mi trovo attualmente nella Missione in
Ghana.

Sto cercando relazioni a lungo termine e assistenza agli investimenti.
Mio padre di beata memoria ha depositato la somma di 27,5 milioni di
dollari in una banca ad Accra in Ghana con il mio nome come parente
pi=C3=B9 prossimo. Avevo contattato la Banca per liquidare la caparra ma il
Direttore di Filiale mi ha detto che essendo rifugiato, il mio status
secondo la legge locale non mi autorizza ad effettuare l'operazione.
Tuttavia, mi ha consigliato di fornire un fiduciario che star=C3=A0 a mio
nome. Avrei voluto informare la mia matrigna di questo deposito ma
temo che non mi offrir=C3=A0 nulla dopo lo svincolo del denaro.

Pertanto, decido di cercare il tuo aiuto per trasferire i soldi sul
tuo conto bancario mentre mi trasferir=C3=B2 nel tuo paese e mi sistemer=C3=
=B2
con te. Poich=C3=A9 hai indicato il tuo interesse ad aiutarmi, ti dar=C3=B2=
 il
numero di conto e il contatto della banca dove il mio amato padre
defunto ha depositato i soldi con il mio nome come parente pi=C3=B9
prossimo. =C3=88 mia intenzione risarcirti con il 40% del denaro totale per
la tua assistenza e il saldo sar=C3=A0 il mio investimento in qualsiasi
impresa redditizia che mi consiglierai poich=C3=A9 non hai alcuna idea
sugli investimenti esteri. Per favore, tutte le comunicazioni devono
avvenire tramite questo indirizzo e-mail per scopi riservati
(manuellawarlordibrahimw@gmail.com).

La ringrazio molto in attesa di una sua rapida risposta. Ti dar=C3=B2 i
dettagli nella mia prossima mail dopo aver ricevuto la tua mail di
accettazione per aiutarmi,

Cordiali saluti
Miss manuella signore della guerra Ibrahim Coulibaly
(manuellawarlordibrahimw@gmail.com)
