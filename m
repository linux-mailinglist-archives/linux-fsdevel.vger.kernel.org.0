Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94040669345
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 10:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbjAMJtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 04:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbjAMJsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:48:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685F4390
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 01:40:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04542B820D0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 09:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A7AC433D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673602797;
        bh=tVoOMfxF9jKUq1BTc9d/pw/Q4l4wfqqk5P1IRqJsETI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=XjoRELITNz2UkkvJINOmamgimgReEOsK5nWOo/qI2nFkIiMKz4UmXZ9CADWSqzR/F
         aLhYuvVPOdEix+EmjS+Iz33ZOv1N+m3jbZkpr+95tdEHuK8oNZTFpKxD2tSHaD2bjM
         /Bq5+V5ae71LELBqoiOLK6LTRSeQknBYWv7meEsZoFjL3b+3GT+9KXl9fvqLedXNI+
         X+ZnxNkS8Ck/xph+MJ+a+UsICCIcsnyrvewPnV9iA56qJxUJ5SRGm3x8EMHhGRMi9d
         CAVlMVbYB8/Uc84P7TMHGWjD6HakyZxzFT6XnM3SdV6KJ2VIltB+EkF4xkWlM1LmJk
         ne7BWfXLVMcGg==
Received: by mail-oi1-f179.google.com with SMTP id o66so17303370oia.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 01:39:57 -0800 (PST)
X-Gm-Message-State: AFqh2krw2+LUyn3sINkFIohx9+9pAV3OnA3jLc31sFTWA4xIvwK5SDaK
        btIs9vk3SSlpxSPSN0tcaW3IedkPprSv0VjI0Q0=
X-Google-Smtp-Source: AMrXdXt/H1QV0HO/bew/MGmM0nnGZlLfaf5UzXxFkPXMztDOBe0lVv6WSubPk0FGRNteM/pWDb9xKLgQ9ZMa2R0CyXA=
X-Received: by 2002:aca:62c5:0:b0:363:a539:4f with SMTP id w188-20020aca62c5000000b00363a539004fmr3951625oib.189.1673602796748;
 Fri, 13 Jan 2023 01:39:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:191:b0:48f:4f77:6cb1 with HTTP; Fri, 13 Jan 2023
 01:39:55 -0800 (PST)
In-Reply-To: <PUZPR04MB631648B2F33E68B31379AFD381C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20230112140509.11525-1-linkinjeon@kernel.org> <PUZPR04MB63165533693F8FD12046D19581C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd8p8mmSaXLNjkzDH=AmrOyhA5DYsjuKEA7=c+1pYfY5AQ@mail.gmail.com>
 <CGME20230113061305epcas1p2ec0bdad0fbe3cca6e3142f99e9260226@epcas1p2.samsung.com>
 <PUZPR04MB63167FAB29A81DB38D43DD5A81C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <626742236.41673593803778.JavaMail.epsvc@epcpadp3> <PUZPR04MB631648B2F33E68B31379AFD381C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 13 Jan 2023 18:39:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Cdu28bXiZaY5PzicBVo40hvdRaNx91a=hiB2G=WymQQ@mail.gmail.com>
Message-ID: <CAKYAXd8Cdu28bXiZaY5PzicBVo40hvdRaNx91a=hiB2G=WymQQ@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: handle unreconized benign secondary entries
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        =?UTF-8?B?QmFyw7Njc2kgRMOpbmVz?= <admin@tveger.hu>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-01-13 17:35 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
>> > > >
>> > > >> +		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
>> > > >> +			exfat_free_benign_secondary_clusters(inode, ep);
>> > > >> +
>> > > >
>> > > > Only vendor allocation entry(0xE1) have associated cluster
>> > > > allocations, vendor extension entry(0xE0) do not have associated
>> > > > cluster
>> > > allocations.
>> > > This is to free associated cluster allocation of the unrecognized
>> > > benign secondary entries, not only vendor alloc entry. Could you
>> > > elaborate more if there is any issue ?
>> >
>> > From exFAT spec, there are 2 types benign secondary entries only,
>> > Vendor Extension entry and Vendor Allocation entry.
>> >
>> > For different Vendor, Different Vendors are distinguished by different
>> > VendorGuid.
>> >
>> > For a better understanding, please refer to
>> > https://urldefense.com/v3/__https://dokumen.pub/sd-__;!!JmoZiZGBv3RvKR
>> >
>> Sx!-iaK3DSO2yh1pGjdOLoZjMhH7s6QEAbN-Yd05bnBzTzpPks10JNCptYbvAdHZ
>> XYYvox
>> > 5D4Pi2xC3TBqH1pHEIg$
>> > specifications-part-2-file-system-specification-version-300.html. This
>> > is the specification that the SD Card Association defines Vendor
>> > Extension entries and Vendor Allocation entries for SD card. "Figure 5-3
>> > :
>> > Continuous Information Management" is an example of an entry set
>> > containing a Vendor Extension entry and a Vendor Allocation entry. In
>> > the example, we can see vendor extension entry(0xE0) do not have
>> > associated cluster allocations.
>>
>> From "8.2 in the exFAT spec" as below, it is needed to handle all
>> unrecognized
>> benign secondary entries that include NOT specified in Revision 1.00.
>>
>> 8.2 Implications of Unrecognized Directory Entries Future exFAT
>> specifications
>> of the same major revision number, 1, and minor revision number higher
>> than
>> 0, may define new benign primary, critical secondary, and benign
>> secondary
>> directory entries. Only exFAT specifications of a higher major revision
>> number
>> may define new critical primary directory entries. Implementations of
>> this
>> specification, exFAT Revision 1.00 File System Basic Specification, should
>> be
>> able to mount and access any exFAT volume of major revision number 1 and
>> any minor revision number. This presents scenarios in which an
>> implementation may encounter directory entries which it does not
>> recognize.
>> The following describe implications of these scenarios:
>> ...
>>   4. Implementations shall not modify unrecognized benign secondary
>>   directory entries or their associated cluster allocations.
>>   Implementations should ignore unrecognized benign secondary directory
>>   entries. When deleting a directory entry set, implementations shall
>>   free all cluster allocations, if any, associated with unrecognized
>>   benign secondary directory entries.
>>
>
> My understanding are
>
> 1. If new benign directory entries are defined in the future, the minor
> version number will be incremented.
>   - If FileSystemRevision is 1.0, Benign secondary is only Vendor Extension
> DirectoryEntry or Vendor Allocation DirectoryEntry.
>   - If FileSystemRevision is higher than 1.0, another Benign secondary
> entries are defined.
>   - So it seems we need to add a check for FileSystemRevision in
> exfat_read_boot_sector()
>     - If FileSystemRevision is higher than 1.0, mount with read only,
> because we can not handle the version.
Well, I can't agree it. The current problem is that exfat has no
handling for unrecognized benign secondary entries. Currently, exfat
does not support vendor alloc/ext entries, so exfat handle
unrecognized benign secondary entry as described in the spec. Of
course, even if a new entry is added to the updated specification
later, there is no problem because it is handled as an unrecognized
benign secondary entry.

>
> 2. Not all Benign secondary have FirstCluster and DataLength Fields.
>   - Vendor Extension DirectoryEntry has no FirstCluster and DataLength
> Fields, and there are no clusters to free when deleting it.
We can know if it is defined by checking the AllocationPossible field
of GeneralSecondaryFlags. If that bit is set, the FirstCluster and
DataLength fields are defined. This patch has code that checks it.

>
>   Table 36 Vendor Extension DirectoryEntry
>   Field Name 			Offset(byte)	Size(byte)
>   EntryType 				0 			1
>   GeneralSecondaryFlags 	1 			1
>   VendorGuid				2			16
>   VendorDefined			18			14
>
>  - Vendor Allocation DirectoryEntry has FirstCluster and DataLength Fields,
> the associated cluster should be freed when deleting it.
>
>   Field Name 			Offset(byte)	Size(byte)
>   EntryType				0 			1
>   GeneralSecondaryFlags 	1			1
>   VendorGuid				2			16
>   VendorDefined			18 			2
>   FirstCluster				20 			4
>   DataLength				24 			8
>
> BTW, I start my Spring Festival vacation tomorrow, so I may not be able to
> respond to emails in time.
>
